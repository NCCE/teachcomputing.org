class Parameter
  def initialize(key, val)
    @key = key
    @val = val
  end

  def to_node
    doc = Nokogiri::HTML::DocumentFragment.parse ''
    node = Nokogiri::XML::Node.new(@key, doc)
    node.content = @val
    node
  end
end
