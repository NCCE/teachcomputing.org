require('nokogiri')
require_relative('achiever')

class CourseTemplate
  attr_accessor :occurrences, :subject_details, :age_range
  def initialize(doc)
    @doc = doc
    @occurrences = []
    @subject_details = nil
    @age_range = nil
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

  def activity_code
    @doc.xpath('.//Template.Activity_Code/text()').to_s
  end

  def workstream
    @doc.xpath('.//Template.Workstream/text()').to_s
  end

  def subjects
    @subject_details.try(:subject_areas)
  end

  def key_stages
    @age_range.try(:key_stages)
  end

  def online_course
    @doc.xpath('.//Template.Online_CPD/text()').to_s.to_i
  end
end
