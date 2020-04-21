class StemCourseDetailsScrubber < Rails::Html::PermitScrubber
  def initialize
    super
    self.tags = %w( div body html p h1 h2 h3 ul li ol strong )
    self.attributes = []
  end

  def allowed_node?(node)
    puts "allowed_node?"
    if node.element?
      strip_nbsp = node.text.gsub(/\u00a0/, '').strip
      puts "node is element with content '#{strip_nbsp}'"
      return false unless strip_nbsp.size.positive?
    end
    puts "super #{node.inspect}"
    super(node)
  end
end
