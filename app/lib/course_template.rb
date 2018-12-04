require('nokogiri')
require_relative('../lib/achiever')

class CourseTemplate
  def initialize(id)
    achiever = Achiever.new
    @doc = achiever.fetchCourseTemplate(id)
  end

  def template_title
    @doc.xpath('.//Template.Template_Title/text()')
  end

  def activity_code
    @doc.xpath('.//Template.Activity_Code/text()')
  end

  def summary
    @doc.xpath('.//Template.Summary/text()')
  end

  def outcomes
    @doc.xpath('.//Template.Outcomes/text()')
  end

  def meta_description
    @doc.xpath('.//Template.Meta_Description/text()')
  end

  def deliverer
    @doc.xpath('.//Template.Deliverer/text()')
  end

  def portal_url
    @doc.xpath('.//Template.TEMPLATEPORTALURL/text()')
  end

  def additional_information
    @doc.xpath('.//Template.Additional_Information/text()')
  end

  def display_programme
    @doc.xpath('.//Template.Display_Programme/text()')
  end

  def itk_cpd_type
    @doc.xpath('.//Template.ITK_CPD_Type/text()')
  end

  def duration_period
    @doc.xpath('.//Template.Duration__x0028_Period_x0029_/text()')
  end

  def duration_no
    @doc.xpath('.//Template.Duration__x0028_No_x0029_/text()')
  end

  def status
    @doc.xpath('.//Template.Status/text()')
  end

  def changed_date
    @doc.xpath('.//Template.Changed_Date/text()')
  end

  def course_template_no
    @doc.xpath('.//Template.COURSETEMPLATENO/text()')
  end
end
