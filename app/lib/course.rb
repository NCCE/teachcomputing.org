require('nokogiri')

class Course
  def initialize(doc)
    @doc = doc
  end

  def activity_code
    @doc.xpath('.//Activity.Activity_Code/text()').to_s
  end

  def instance_code
    @doc.xpath('.//Activity.Instance_Code/text()').to_s
  end

  def activity_title
    @doc.xpath('.//Activity.Activity_Title/text()').to_s
  end

  def start_date
    @doc.xpath('.//Activity.Start_Date__x0028_Portal_x0029_/text()').to_s
  end

  def end_date
    @doc.xpath('.//Activity.End_Date__x0028_Portal_x0029_/text()').to_s
  end

  def template_duration_period
    @doc.xpath('.//Template.Duration__x0028_Period_x0029_/text()').to_s
  end

  def template_duration_no
    @doc.xpath('.//Template.Duration__x0028_Period_x0029_/text()').to_s
  end

  def activity_duration_period
    @doc.xpath('.//Activity.Duration__x0028_Period_x0029_/text()').to_s
  end

  def activity_duration_no
    @doc.xpath('.//Activity.Duration__x0028_Period_x0029_/text()').to_s
  end

  def summary
    @doc.xpath('.//Activity.Summary/text()').to_s
  end

  def meta_description
    @doc.xpath('.//Template.Meta_Description/text()').to_s
  end

  def portal_course_url
    @doc.xpath('.//Activity.PORTALCOURSEURL/text()').to_s
  end

  def deliverer
    @doc.xpath('.//Activity.Deliverer/text()').to_s
  end

  def region
    @doc.xpath('.//Activity.Region/text()').to_s
  end

  def address_no
    @doc.xpath('.//Activity_Venue_Address.ADDRESSNO/text()').to_s
  end

  def address_venue_name
    @doc.xpath('.//Activity_Venue_Address.Venue_Name/text()').to_s
  end

  def address_town
    @doc.xpath('.//Activity_Venue_Address.Town_x002F_City/text()').to_s
  end

  def address_postcode
    @doc.xpath('.//Activity_Venue_Address.Postcode/text()').to_s
  end

  def activity_occurrence_id
    @doc.xpath('.//Activity.Activity_Occurrence_ID/text()').to_s
  end

  def status
    @doc.xpath('.//Activity.Status/text()').to_s
  end

  def display_programme
    @doc.xpath('.//Activity.Display_Programme/text()').to_s
  end

  def itk_cpd_type
    @doc.xpath('.//Activity.ITK_CPD_Type/text()').to_s
  end

  def programme
    @doc.xpath('.//Template.Programme/text()').to_s
  end

  def places_remaining
    @doc.xpath('.//Activity.Places_Remaining/text()').to_s
  end

  def pay_later
    @doc.xpath('.//Activity.Pay_Later/text()').to_s
  end

  def epayment
    @doc.xpath('.//Activity.ePayment/text()').to_s
  end

  def changed_date
    @doc.xpath('.//Activity.Changed_Date/text()').to_s
  end

  def everest_occurrence_changed_date
    @doc.xpath('.//Activity.Everest_Occurrence_Changed_Date/text()').to_s
  end

  def imported_to_itk
    @doc.xpath('.//Activity.Imported_to_ITK/text()').to_s
  end

  def course_occurrence_no
    @doc.xpath('.//Activity.COURSEOCCURRENCENO/text()').to_s
  end

  def course_template_no
    @doc.xpath('.//Template.COURSETEMPLATENO/text()').to_s
  end
end
