require('nokogiri')

class Course
  def initialize(xml)
    @activity_code = xml.xpath('.//Activity.Activity_Code/text()')
    @instance_code = xml.xpath('.//Activity.Instance_Code/text()')
    @activity_title = xml.xpath('.//Activity.Activity_Title/text()')
    @start_date = xml.xpath('.//Activity.Start_Date__x0029_Portal_x0029_/text()')
    @end_date = xml.xpath('.//Activity.End_Date__x0029_Portal_x0029_/text()')
    @template_duration_period = xml.xpath('.//Template.Duration__x0029_Period_x0029_/text()')
    @template_duration_no = xml.xpath('.//Template.Duration__x0029_Period_x0029_/text()')
    @activity_duration_period = xml.xpath('.//Activity.Duration__x0029_Period_x0029_/text()')
    @activity_duration_no = xml.xpath('.//Activity.Duration__x0029_Period_x0029_/text()')
    @summary = xml.xpath('.//Activity.Summary/text()')
    @meta_description = xml.xpath('.//Activity.Meta_Description/text()')
    @portal_course_url = xml.xpath('.//Activity.PORTALCOURSEURL/text()')
    @deliverer = xml.xpath('.//Activity.Deliverer/text()')
    @activity_code = xml.xpath('.//Activity.Region/text()')
    @address_no = xml.xpath('.//Activity_Venue_Address.ADDRESSNO/text()')
    @address_venue_name = xml.xpath('.//Activity_Venue_Address.Venue_Name/text()')
    @address_town = xml.xpath('.//Activity_Venue_Address.Town_x002F_City/text()')
    @address_postcode = xml.xpath('.//Activity_Venue_Address.Postcode/text()')
    @activity_occurrence_id = xml.xpath('.//Activity.Activity_Occurrence_ID/text()')
    @status = xml.xpath('.//Activity.Status/text()')
    @display_programme = xml.xpath('.//Activity.Display_Programme/text()')
    @itk_cpd_type = xml.xpath('.//Activity.ITK_CPD_Type/text()')
    @programme = xml.xpath('.//Template.Programme/text()')
    @places_remaining = xml.xpath('.//Activity.Places_Remaining/text()')
    @pay_later = xml.xpath('.//Activity.Pay_Later/text()')
    @epayment = xml.xpath('.//Activity.ePayment/text()')
    @changed_date = xml.xpath('.//Activity.Changed_Date/text()')
    @everest_occurrence_changed_date = xml.xpath('.//Activity.Everest_Occurrence_Changed_Date/text()')
    @imported_to_itk = xml.xpath('.//Activity.Imported_to_ITK/text()')
    @course_occurence_no = xml.xpath('.//Activity.COURSEOCCURRENCENO/text()')
    @course_template_no = xml.xpath('.//Template.COURSETEMPLATENO/text()')
  end

  def activity_code
    @activity_code
  end

  def instance_code
    @instance_code
  end

  def activity_title
    @activity_title
  end

  def start_date
    @start_date
  end

  def end_date
    @end_date
  end

  def template_duration_period
    @template_duration_period
  end

  def template_duration_no
    @template_duration_no
  end

  def activity_duration_period
    @activity_duration_period
  end

  def activity_duration_no
    @activity_duration_no
  end

  def summary
    @summary
  end

  def meta_description
    @meta_description
  end

  def portal_course_url
    @portal_course_url
  end

  def deliverer
    @deliverer
  end

  def activity_code
    @activity_code
  end

  def address_no
    @address_no
  end

  def address_venue_name
    @address_venue_name
  end

  def address_town
    @address_town
  end

  def address_postcode
    @address_postcode
  end

  def activity_occurrence_id
    @activity_occurrence_id
  end

  def status
    @status
  end

  def display_programme
    @display_programme
  end

  def itk_cpd_type
    @itk_cpd_type
  end

  def programme
    @programme
  end

  def places_remaining
    @places_remaining
  end

  def pay_later
    @pay_later
  end

  def epayment
    @epayment
  end

  def changed_date
    @changed_date
  end

  def everest_occurrence_changed_date
    @everest_occurrence_changed_date
  end

  def imported_to_itk
    @imported_to_itk
  end

  def course_occurence_no
    @course_occurence_no
  end

  def course_template_no
    @course_template_no
  end

  def print()
    puts @activity_code
    puts @instance_code
    puts @activity_title
    puts @start_date
    puts @end_date
    puts @template_duration_period
    puts @template_duration_no
    puts @activity_duration_period
    puts @activity_duration_no
    puts @summary
    puts @meta_description
    puts @portal_course_url
    puts @deliverer
    puts @activity_code
    puts @address_no
    puts @address_venue_name
    puts @address_town
    puts @address_postcode
    puts @activity_occurrence_id
    puts @status
    puts @display_programme
    puts @itk_cpd_type
    puts @programme
    puts @places_remaining
    puts @pay_later
    puts @epayment
    puts @changed_date
    puts @everest_occurrence_changed_date
    puts @imported_to_itk
    puts @course_occurence_no
    puts @course_template_no
  end
end
