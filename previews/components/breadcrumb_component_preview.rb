class BreadcrumbComponentPreview < ViewComponent::Preview
  def default
    render(BreadcrumbComponent.new(ancestors: [[root_path, "Home"], [cms_posts_path, "Articles"]], current_page_name: "This Article"))
  end
end
