class StemCourseDetailsScrubber < Rails::Html::PermitScrubber
  def initialize
    super
    self.tags = %w[a div body html p h1 h2 h3 h4 ul li ol strong video track source]
    self.attributes = %w[name href src]
    @video_attributes = %w[poster controls playsinline crossorigin preload tabindex src type class kind srclang label]
  end

  def video_element?(node)
    %w[video track source].include?(node.name)
  end

  def scrub_attributes(node)
    if video_element?(node)
      node.attribute_nodes.each do |attr|
        attr.remove unless @video_attributes.include?(attr.name)
        scrub_attribute(node, attr)
      end
      scrub_css_attribute(node)
    else
      super(node)
    end
  end

  def strip_nbsp(node)
    node.text.delete("\u00a0").strip
  end

  def skip_node?(node)
    node.text? && strip_nbsp(node).size.positive?
  end

  def allowed_node?(node)
    unless video_element?(node)
      return false unless strip_nbsp(node).size.positive?
    end

    super(node)
  end
end
