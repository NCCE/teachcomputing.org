require('nokogiri')
require_relative('achiever')

class CourseTemplateAgeRange
  def initialize(doc)
    @doc = doc
  end

  def key_stages
    key_stages = []
    @doc.xpath('.//Portal_Age_Groups.Age_Range').each do |node|
      if /^(K|k)ey (S|s)tage\s+([0-9]+)/.match?(node.content)
        key_stages.push(node.content)
      end
    end
    key_stages
  end
end
