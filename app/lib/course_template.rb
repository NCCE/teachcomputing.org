require('nokogiri')
require_relative('achiever')

class CourseTemplate
  def initialize(doc)
    @doc = doc
  end

  def booking_url
    @doc.xpath('.//Template.Booking_URL/text()').to_s
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
    @doc.xpath('.//Template.Meta_Description/text()').to_s
  end
end
