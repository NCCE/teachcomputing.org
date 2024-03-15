require "open-uri"

class GhostToStrapi
  def initialize
    @ghost_api = ENV["GHOST_API_ENDPOINT"]
    @ghost_api_key = ENV["GHOST_CONTENT_API_KEY"]
    @strapi_api = ENV["STRAPI_URL"]
    @strapi_api_key = ENV["STRAPI_API_WRITE_KEY"]

    @current_slug = nil
    @image_count = 0
  end

  def convert_posts(post_count)
    process_posts(get_posts_from_ghost(post_count))
  end

  def convert_pages(page_count)
    process_pages(get_pages_from_ghost(page_count))
  end

  def process_pages(pages)
    problem_pages = []
    pages["pages"].each do |post|
      @current_slug = post["slug"]
      @image_count = 0
      data = ghost_page_to_strapi_json(post)
      begin
        upload_to_strapi(data, "simple-pages")
      rescue => e
        problem_pages << {
          slug: data[:slug],
          problem: e,
          data:
        }
      end
    end
    puts "\n\n== Problem Pages (#{problem_pages.count}) ==\n\n"
    problem_pages.each do |x|
      puts x[:slug]
      x = {data: x[:data]}.to_json
      puts x
    end
  end

  def process_posts(posts)
    problem_pages = []
    all_tags = get_strapi_tags
    posts["posts"].each do |post|
      @current_slug = post["slug"]
      @image_count = 0
      data = ghost_post_to_strapi_json(post, all_tags)
      begin
        upload_to_strapi(data, "blogs")
      rescue => e
        problem_pages << {
          slug: data[:slug],
          problem: e,
          data:
        }
      end
    end
    puts "\n\n== Problem Posts (#{problem_pages.count}) ==\n\n"
    problem_pages.each do |x|
      puts x[:slug]
      x = {data: x[:data]}.to_json
      puts x
    end
  end

  def check_strapi_for_image(filename)
    images = JSON.parse(RestClient.get("#{@strapi_api}/upload/files", {
      params: {
        filters: {
          name: {
            "$eq": filename
          }
        }
      },
      Authorization: "Bearer #{@strapi_api_key}"
    }).body)

    images.first if images.any?
  end

  def upload_to_strapi(data, resource_key)
    slug = data[:slug]
    params = JSON.generate({data:})
    headers = {
      Authorization: "Bearer #{@strapi_api_key}",
      content_type: :json
    }
    begin
      record = JSON.parse(RestClient.get("#{@strapi_api}/#{resource_key}/#{slug}", {
        Authorization: "Bearer #{@strapi_api_key}"
      }).body)
      id = record["data"]["id"]
      puts "updating #{slug}"
      RestClient.put("#{@strapi_api}/#{resource_key}/#{id}", params, headers)
    rescue RestClient::NotFound
      puts "creating #{slug}"
      RestClient.post("#{@strapi_api}/#{resource_key}", params, headers)
    end
  end

  def ghost_post_to_strapi_json(post, tag_list)
    tag_ids = post["tags"].each_with_object([]) do |tag, arr|
      match = tag_list.find { |x| x["attributes"]["slug"] == tag["slug"] }
      if match
        arr << match["id"]
      end
    end
    data = {
      slug: post["slug"],
      title: post["title"],
      publishDate: post["published_at"],
      excerpt: post["custom_excerpt"] || post["excerpt"],
      seo: {
        description: post["custom_excerpt"] || post["excerpt"],
        title: post["title"]
      },
      blog_tags: tag_ids
    }
    if post["feature_image"]
      caption_doc = Nokogiri::HTML::DocumentFragment.parse(post["feature_image_caption"])
      caption_text = caption_doc.children.first&.text
      featured_image = process_image(post["feature_image"], alt: post["feature_image_alt"], caption: caption_text)
      if featured_image
        data[:featuredImage] = {
          id: featured_image[:image]["id"]
        }
      end
    end
    data[:content] = process_html(post["html"])
    data
  end

  def ghost_page_to_strapi_json(post)
    data = {
      slug: post["slug"],
      title: post["title"],
      publishDate: post["published_at"],
      excerpt: post["custom_excerpt"] || post["excerpt"],
      seo: {
        description: post["custom_excerpt"] || post["excerpt"],
        title: post["title"]
      }
    }
    data[:content] = process_html(post["html"])
    data
  end

  def process_html(content)
    doc = Nokogiri::HTML::DocumentFragment.parse(content)
    blocks = []
    in_code_block = false
    code_block_content = []
    doc.children.each do |child|
      if in_code_block
        if child.text == "kg-card-end: html"
          in_code_block = false
          code_block = process_code_block(code_block_content)
          blocks << code_block if code_block[:children].any?
        else
          code_block_content << child.to_s
        end
      elsif child.element?
        case child.name
        when "p"
          para = process_para(child)
          blocks << para if para[:children].any?
        when "blockquote"
          blocks << process_para(child, type: "quote")
        when "figure"
          figure = process_figure(child)
          blocks << figure if figure
        when "ul"
          blocks << process_list(child, "unordered")
        when "ol"
          blocks << process_list(child, "ordered")
        when "hr"
          blocks << {
            type: "paragraph",
            children: [{
              type: "text",
              text: "---"
            }]
          }
        when /h(\d)/
          blocks << process_heading(child)
        end
      elsif child.comment?
        if child.text == "kg-card-begin: html"
          in_code_block = true
          code_block_content = []
        end
      end
    end
    blocks.compact
  end

  def process_code_block(lines)
    {
      type: "paragraph",
      children: lines.filter_map {
        unless _1.empty? || /^\s$/.match?(_1)
          {
            code: true,
            text: _1.to_s,
            type: "text"
          }
        end
      }
    }
  end

  def process_figure(element)
    classes = element.attributes["class"].value
    # TC only uses the two types of card, image-card or embed-card
    if classes.include?("kg-image-card")
      img = element.search("img").first
      return unless img

      src = img.attributes["src"].value
      return unless src

      alt = img.attributes["alt"]&.value
      if (caption_element = element.search("figcaption")).any?
        caption_span = caption_element.find("span")
        if caption_span
          caption = caption_span.first.children.first.text
        end
      end
      process_image(src, alt:, caption:)
    elsif classes.include?("kg-embed-card")
      process_code_block([element.to_s])
    end
  end

  def process_image(image_url, alt: nil, caption: nil)
    uri = URI.parse(image_url)
    extension = File.extname(uri.path)
    extension = ".png" if extension.blank?
    filename = "#{@current_slug}-#{@image_count}#{extension}"
    strapi_image = check_strapi_for_image filename
    unless strapi_image
      begin
        uri.open do |image|
          File.binwrite("tmp/#{filename}", image.read)
        end
        params = {
          files: File.open("tmp/#{filename}")
        }
        response = JSON.parse(RestClient.post("#{@strapi_api}/upload",
          params, {Authorization: "Bearer #{@strapi_api_key}"}).body)
        File.delete("tmp/#{filename}")
        strapi_image = response.first
      rescue OpenURI::HTTPError
        strapi_image = nil
      end
    end

    @image_count += 1
    if strapi_image
      file_info_params = {
        fileInfo: {
          name: filename,
          caption:,
          alternativeText: alt
        }
      }
      RestClient.post("#{@strapi_api}/upload?id=#{strapi_image["id"]}", file_info_params, {Authorization: "Bearer #{@strapi_api_key}"})

      {
        type: "image",
        image: strapi_image,
        children: [{
          type: "text",
          text: ""
        }]
      }
    end
  end

  def process_heading(element)
    match = /h(\d)/.match(element.name)
    {
      type: "heading",
      level: match[1],
      children: [
        {
          text: element.content,
          type: "text"
        }
      ]
    }
  end

  def process_list(element, type)
    {
      type: "list",
      format: type,
      children: element.children.map {
        {
          type: "list-item",
          children: [
            {
              type: "text",
              text: _1.content
            }
          ]
        }
      }
    }
  end

  def process_para(content, type: "paragraph")
    {
      type:,
      children: content.children.map { process_children(_1) }.compact
    }
  end

  def process_children(block)
    case block.name
    when "a"
      href = block.attributes["href"]&.value
      {
        type: "link",
        url: process_link_url(href),
        children: block.children.map { process_children(_1) }.compact
      }
    when "blockquote"
      {
        type: "quote",
        children: block.children.map { process_children(_1) }
      }
    when "strong"
      {
        type: "text",
        text: block.text,
        bold: true
      }
    when "em"
      {
        type: "text",
        text: block.text,
        italic: true
      }
    when "text"
      {
        type: "text",
        text: block.text
      }
    end
  end

  def process_link_url(href)
    url = URI.parse(href)
    if url.scheme.nil?
      url.scheme = "https"
    end
    if url.host == "blog.teachcomputing.org"
      url.host = "teachcomputing.org"
      url.path = "/blog#{url.path}"
      puts "updated link #{@current_slug}"
    end
    url.to_s
  end

  def get_strapi_tags
    JSON.parse(RestClient.get("#{@strapi_api}/blog-tags", {Authorization: "Bearer #{@strapi_api_key}"}).body)["data"]
  end

  def get_posts_from_ghost(post_count)
    request = "#{@ghost_api}/content/posts"
    params = {
      key: @ghost_api_key,
      limit: post_count,
      fields: "title,slug,feature_image,custom_excerpt,excerpt,published_at,html,feature_image_alt,feature_image_caption",
      include: "tags",
      page: 0
    }.compact
    JSON.parse(RestClient.get(request, params: params).body)
  end

  def get_pages_from_ghost(page_count)
    request = "#{@ghost_api}/content/pages"
    params = {
      key: @ghost_api_key,
      limit: page_count,
      fields: "title,slug,custom_excerpt,excerpt,published_at,html",
      include: "tags",
      page: 0
    }.compact
    JSON.parse(RestClient.get(request, params: params).body)
  end
end
