require('nokogiri')
require_relative('../lib/achiever')

class CourseOccurrence
  def initialize(id)
    achiever = Achiever.new
    @doc = achiever.fetchCourseOccurrence(id)
  end

  def activity_title
    @doc.xpath('.//Activity.Activity_Title/text()')
  end

  def start_date
    @doc.xpath('.//Activity.Start_Date__x0028_Portal_x0029_/text()')
  end

  def end_date
    @doc.xpath('.//Activity.End_Date__x0028_Portal_x0029_/text()')
  end

  def activity_code
    @doc.xpath('.//Activity.Activity_Code/text()')
  end

  def summary
    @doc.xpath('.//Activity.Summary/text()')
  end

  def outcomes
    @doc.xpath('.//Activity.Outcomes/text()')
  end

  def places_remaining
    @doc.xpath('.//Activity.Places_Remaining/text()')
  end

  def topic
    @doc.xpath('.//Activity.Topic/text()')
  end

  def meta_description
    @doc.xpath('.//Template.Meta_Description/text()')
  end

  def additional_information
    @doc.xpath('.//Activity.Additional_Information/text()')
  end

  def portal_course_url
    @doc.xpath('.//Activity.PORTALCOURSEURL/text()')
  end

  def session_start_time
    @doc.xpath('.//Activity.Session_Start_Time/text()')
  end

  def session_end_time
    @doc.xpath('.//Activity.Session_End_Time/text()')
  end

  def instance_code
    @doc.xpath('.//Activity.Instance_Code/text()')
  end

  def deliverer
    @doc.xpath('.//Activity.Deliverer/text()')
  end

  def template_duration_period
    @doc.xpath('.//Template.Duration__x0028_Period_x0029_/text()')
  end

  def template_duration_no
    @doc.xpath('.//Template.Duration__x0028_No_x0029_/text()')
  end

  def duration_period
    @doc.xpath('.//Activity.Duration__x0028_Period_x0029_/text()')
  end

  def duration_no
    @doc.xpath('.//Activity.Duration__x0028_No_x0029_/text()')
  end

  def address_venue_name
    @doc.xpath('.//Activity_Venue_Address.Venue_Name/text()')
  end

  def address_venue_code
    @doc.xpath('.//Activity_Venue_Address.Venue_Code/text()')
  end

  def address_town
    @doc.xpath('.//Activity_Venue_Address.Town_x002F_City/text()')
  end

  def address_postcode
    @doc.xpath('.//Activity_Venue_Address.Postcode/text()')
  end

  def address_line_1
    @doc.xpath('.//Activity_Venue_Address.Line_1/text()')
  end

  def address_no
    @doc.xpath('.//Activity_Venue_Address.ADDRESSNO/text()')
  end

  def template_title
    @doc.xpath('.//Template.Template_Title/text()')
  end

  def status
    @doc.xpath('.//Activity.Status/text()')
  end

  def fee
    @doc.xpath('.//Activity.Fee__x0028_ex_VAT_x0029_/text()')
  end

  def pay_later
    @doc.xpath('.//Activity.Pay_Later/text()')
  end

  def epayment
    @doc.xpath('.//Activity.ePayment/text()')
  end

  def changed_date
    @doc.xpath('.//Activity.Changed_Date/text()')
  end

  def everest_occurrence_changed_date
    @doc.xpath('.//Activity.Everest_Occurrence_Changed_Date/text()')
  end

  def cpd_type
    @doc.xpath('.//Activity.CPD_Type/text()')
  end

  def display_programme
    @doc.xpath('.//Activity.Display_Programme/text()')
  end

  def itk_cpd_type
    @doc.xpath('.//Activity.ITK_CPD_Type/text()')
  end

  def imported_to_itk
    @doc.xpath('.//Activity.Imported_to_ITK/text()')
  end

  def award_value
    @doc.xpath('.//Activity.Award_Value/text()')
  end

  def fee_category
    @doc.xpath('.//Activity.Fee__Category/text()')
  end

  def course_occurrence_no
    @doc.xpath('.//Activity.COURSEOCCURRENCENO/text()')
  end

  def course_template_no
    @doc.xpath('.//Template.COURSETEMPLATENO/text()')
  end
end
