require('nokogiri')

class DelegateCourse
  def initialize(doc)
    @doc = doc
  end

  def enquiry_no
    @doc.xpath('.//Application_x002F_Enrolment.ENQUIRYNO/text()').to_s
  end

  def application_no
    @doc.xpath('.//Application_x002F_Enrolment.Application_No/text()').to_s
  end

  def enrolment_status
    @doc.xpath('.//Application_x002F_Enrolment.Status/text()').to_s
  end

  def reference
    @doc.xpath('.//Productlines.Reference/text()').to_s
  end

  def product_line_no
    @doc.xpath('.//Productlines.PRODLINENO/text()').to_s
  end

  def course_occurrence_no
    @doc.xpath('.//Productlines.COURSEOCCURRENCENO/text()').to_s
  end

  def product_line_type
    @doc.xpath('.//Productlines.Type/text()').to_s
  end

  def activity_title
    @doc.xpath('.//Activity.Activity_Title/text()').to_s
  end

  def start_date
    @doc.xpath('.//Activity.Start_Date/text()').to_s
  end

  def end_date
    @doc.xpath('.//Activity.End_Date/text()').to_s
  end

  def requested_cancellation
    @doc.xpath('.//Productlines.Requested_Cancellation/text()').to_s
  end

  def address_line_1
    @doc.xpath('.//Activity_Venue_Address.Line_1/text()').to_s
  end

  def address_town
    @doc.xpath('.//Activity_Venue_Address.Town_x002F_City/text()').to_s
  end

  def address_postcode
    @doc.xpath('.//Activity_Venue_Address.Postcode/text()').to_s
  end

  def post_enrolment_optional_activity_modification
    @doc.xpath('.//Activity.PostEnrolment_Optional_Activity_Modification/text()').to_s
  end

  def imported_to_itk
    @doc.xpath('.//Activity.Imported_to_ITK/text()').to_s
  end

  def address_no
    @doc.xpath('.//Activity_Venue_Address.ADDRESSNO/text()').to_s
  end

  def delegate_booker_first_name
    @doc.xpath('.//Delegate.Booker First Name/text()').to_s
  end

  def delegate_booker_surname
    @doc.xpath('.//Delegate.Booker Surname/text()').to_s
  end

  def delegate_Booker_company
    @doc.xpath('.//Delegate.Booker Company/text()').to_s
  end

  def delegate_first_name
    @doc.xpath('.//Delegate.First Name/text()').to_s
  end

  def delegate_calculated_surname
    @doc.xpath('.//Delegate.Calculated Surname/text()').to_s
  end

  def delegate_calculated_email_address
    @doc.xpath('.//Delegate.Calculated Email Address/text()').to_s
  end

  def delegate_registration_status
    @doc.xpath('.//Delegate.Registration Status/text()').to_s
  end

  def delegate_cancellation_requested
    @doc.xpath('.//Delegate.Cancellation Requested/text()').to_s
  end

  def delegate_progress
    @doc.xpath('.//Delegate.Progress/text()').to_s
  end

  def delegate_course_place_no
    @doc.xpath('.//Delegate.COURSEPLACENO/text()').to_s
  end
end
