# frozen_string_literal: true

class FeaturedBlogPostsComponent < ViewComponent::Base
  def initialize(number_to_display:, show_main_feature: true, title: "News and Updates")
    @title = title
    posts =
      begin
        response = Cms::Collections::Blog.all(1, number_to_display, params: {
          query: {
            featured: true
          }
        })

        response.resources
      rescue ActiveRecord::RecordNotFound
        []
      end

    if show_main_feature
      @main_feature, *@featured_posts = posts.map { |x| x.data_models.first }
    else
      @featured_posts = posts.map { |x| x.data_models.first }
    end
  end

  def published_date(iso_date)
    return if iso_date.nil?
    iso_date.strftime("%-d %B %Y")
  end
end
