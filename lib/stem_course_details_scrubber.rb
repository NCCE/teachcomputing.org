class StemCourseDetailsScrubber < Rails::Html::PermitScrubber
  def initialize
    super
    self.tags = %w( div body html p h1 h2 h3 h4 ul li ol strong video track source)
    self.attributes = ['src']
    @video_attributes = %w( poster controls playsinline crossorigin preload tabindex src type class kind srclang label)
  end

  def is_video_element?(node)
    node.name == 'video' || node.name == 'track' || node.name == 'source'
  end

  def scrub_attributes(node)
    if is_video_element?(node)
      node.attribute_nodes.each do |attr|
        attr.remove unless @video_attributes.include?(attr.name)
        scrub_attribute(node, attr)
      end
      scrub_css_attribute(node)
    else
      super(node)
    end
  end

  def skip_node?(node)
    node.text? && node.text.gsub(/\u00a0/, '').strip.size.positive?
  end

  def allowed_node?(node)
    unless is_video_element?(node)
      strip_nbsp = node.text.gsub(/\u00a0/, '').strip
      return false unless strip_nbsp.size.positive?
    end

    super(node)
  end
end
