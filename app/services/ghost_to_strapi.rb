require "open-uri"

class GhostToStrapi
  def initialize
    @ghost_api = ENV["GHOST_API_ENDPOINT"]
    @ghost_api_key = ENV["GHOST_CONTENT_API_KEY"]
    @strapi_api = ENV["STRAPI_URL"]
    # @strapi_api_key = ENV["STRAPI_API_KEY"]
    @strapi_api_key = "bedc6970b970cd86595250ce4825f4cc7f9bb7203b2b5cc228b7de79aae303342c2adf40243c546ff7cfdda23d3bde114801295c534b03757f5fcb35477c775bc0b3f2e320c9a476e1953c81cfb9884284c1d124adda1227465e18946b1911de39ef879edfb395dd6826473b0ef9b4460a99ceae547342bdad18e9342a249092"

    @current_slug = nil
    @image_count = 0
  end

  def convert_post key
    posts = get_posts_from_ghost(400)
    post = posts["posts"].find{ _1["slug"] == key }
    process_posts({ "posts" => [post] })
  end

  def convert_posts post_count
    process_posts(get_posts_from_ghost(post_count))
  end

  def process_posts posts
    problem_pages = []
    all_tags = get_strapi_tags
    posts["posts"].each do |post|
      @current_slug = post["slug"]
      @image_count = 0
      data = ghost_to_strapi_json(post, all_tags)
      begin
        upload_to_strapi(data)
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

  def check_strapi_for_image filename
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
    if images.any?
      images.first
    end
  end

  def upload_to_strapi data
    slug = data[:slug]
    params = JSON.generate({data:})
    headers = {
      Authorization: "Bearer #{@strapi_api_key}",
      content_type: :json
    }
    begin
      record = JSON.parse(RestClient.get("#{@strapi_api}/blogs/#{slug}", {
        Authorization: "Bearer #{@strapi_api_key}"
      }).body)
      id = record["data"]["id"]
      puts "updating #{slug}"
      RestClient.put("#{@strapi_api}/blogs/#{id}", params, headers)
    rescue RestClient::NotFound
      puts "creating #{slug}"
      RestClient.post("#{@strapi_api}/blogs", params, headers)
    end
  end

  def ghost_to_strapi_json post, tag_list
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
      blog_tags: tag_ids,
      content: process_html(post["html"]),
    }
    if post["feature_image"]
      featured_image = process_image(post["feature_image"])
      if featured_image
        data[:featuredImage] = {
          id: featured_image[:image]["id"]
        }
      end
    end
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
          blocks << {
            type: "paragraph",
            children: code_block_content.map {
              {
                code: true,
                text: _1.to_s,
                type: "text"
              }
            }
          }
        else
          code_block_content << child.to_s
        end
      elsif child.element?
        case child.name
        when "p"
          para = process_para(child)
          if para[:children].any?
            blocks << para
          end
        when "figure"
          blocks << process_figure(child)
        when "img"
          blocks << process_image(child)
        when "ul"
          blocks << process_list(child, "unordered")
        when "ol"
          blocks << process_list(child, "ordered")
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

  def process_figure element
    img = element.search("img").first
    if img
      src = img.attributes["src"].value
      if src
        process_image(src)
      end
    end
  end

  def process_image image_url
    uri = URI.parse(image_url)
    extension = File.extname(uri.path) || "png"
    filename = "#{@current_slug}-#{@image_count}#{extension}"
    strapi_image = check_strapi_for_image filename
    unless strapi_image
      begin
        uri.open do |image|
          File.binwrite("tmp/#{filename}", image.read)
        end
        response = JSON.parse(RestClient.post("#{@strapi_api}/upload",
          {
            files: File.open("tmp/#{filename}")
          },
          {
            Authorization: "Bearer #{@strapi_api_key}"
          }).body)
        File.delete("tmp/#{filename}")
        strapi_image = response.first
      rescue OpenURI::HTTPError
        strapi_image = nil
      end
    end

    @image_count += 1
    {
      type: "image",
      image: strapi_image,
      children: [{
        type: "text",
        text: ""
      }]
    } if strapi_image
  end

  def process_heading element
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

  def process_list element, type
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

  def process_para content
    {
      type: "paragraph",
      children: content.children.map { process_children(_1) }.compact
    }
  end

  def process_children block
    case block.name
    when "a"
      begin
        href = block.attributes["href"]&.value
        if /^#.*/.match(href)
          {
            type: "link",
            url: "https://teachcomputing.org/blog/#{@current_slug}#{href}",
            children: block.children.map { process_children(_1) }.compact
          }
        else
          {
            type: "link",
            url: process_link_url(href),
            children: block.children.map { process_children(_1) }.compact
          }
        end
      rescue
        # TODO fix me, this is inserting children into text blocks
        {
          type: "text",
          children: block.children.map { process_children(_1) }.compact
        }
      end
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

  def process_link_url url
    url = URI.parse(href)
    #url_string = unless url.scheme
    unless url.scheme
      url.scheme = "https"
    else
      url.to_s
    end
  end

  def get_strapi_tags
    JSON.parse(RestClient.get("#{@strapi_api}/blog-tags", {Authorization: "Bearer #{@strapi_api_key}"}).body)["data"]
  end

  def get_posts_from_ghost post_count
    request = "#{@ghost_api}/content/posts"
    params = {
      key: @ghost_api_key,
      limit: post_count,
      fields: "title,slug,feature_image,custom_excerpt,excerpt,published_at,html",
      include: "tags",
      page: 0
      # order: "published_at ASC"
    }.compact
    JSON.parse(RestClient.get(request, params: params).body)
  end
end
