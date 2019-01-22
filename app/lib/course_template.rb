require('nokogiri')
require_relative('achiever')

class CourseTemplate
  include ActionView::Helpers::SanitizeHelper

  def initialize(doc)
   @doc = doc
   achiever = Achiever.new
   @course_template_details = achiever.fetchCourseTemplate(course_template_no)
  end

  def course_template_no
    @doc.xpath('.//Template.COURSETEMPLATENO/text()').to_s
  end

  def summary
    @doc.xpath('.//Template.Summary/text()').to_s
  end

  def title
    @doc.xpath('.//Template.Template_Title/text()').to_s
  end

  def meta_description
    @course_template_details.xpath('.//Template.Meta_Description/text()').to_s
  end
end
