require('nokogiri')
require_relative('achiever')

class CourseTemplateSubjectDetails
  def initialize(doc)
    @doc = doc
  end

  def subject_areas
    @doc.xpath('.//Portal_Subject_Areas.Subject_Area').map(&:content)
  end
end
