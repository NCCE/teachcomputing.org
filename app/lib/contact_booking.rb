require('nokogiri')

class ContactBooking
  def initialize(doc)
    @doc = doc
  end

  def enquiry_no
    @doc.xpath('.//Application_x002F_Enrolment.ENQUIRYNO/text()').to_s
  end

  def application_no
    @doc.xpath('.//Application_x002F_Enrolment.Application_No/text()').to_s
  end

  def original_total_value
    @doc.xpath('.//Application_x002F_Enrolment.Original_Total_Value/text()').to_s
  end

  def total_value
    @doc.xpath('.//Application_x002F_Enrolment.Total_Value/text()').to_s
  end

  def original_total_value_inc_vat
    @doc.xpath('.//Application_x002F_Enrolment.Original_Total_Value_inc._VAT/text()').to_s
  end

  def total_value_inc_vat
    @doc.xpath('.//Application_x002F_Enrolment.Total_Value_inc._VAT/text()').to_s
  end

  def discount_code
    @doc.xpath('.//Application_x002F_Enrolment.Discount_Code/text()').to_s
  end

  def application_date
    @doc.xpath('.//Application_x002F_Enrolment.Application_Date/text()').to_s
  end

  def order_date
    @doc.xpath('.//Application_x002F_Enrolment.Order_Date/text()').to_s
  end

  def enrolment_status
    @doc.xpath('.//Application_x002F_Enrolment.Status/text()').to_s
  end

  def payment_method
    @doc.xpath('.//Application_x002F_Enrolment.Payment_Method/text()').to_s
  end

  def fee_category
    @doc.xpath('.//Application_x002F_Enrolment.Fee_Category/text()').to_s
  end

  def organisation_name
    @doc.xpath('.//Organisation.Organisation_Name/text()').to_s
  end

  def company_no
    @doc.xpath('.//Organisation.COMPANYNO/text()').to_s
  end

  def reference
    @doc.xpath('.//Productlines.Reference/text()').to_s
  end

  def product_line_no
    @doc.xpath('.//Productlines.PRODLINENO/text()').to_s
  end

  def product_line_status
    @doc.xpath('.//Productlines.Status/text()').to_s
  end

  def product_line_original_value
    @doc.xpath('.//Productlines.Original_Value/text()').to_s
  end

  def product_line_total_discounted_value
    @doc.xpath('.//Productlines.Total_Discounted_Value/text()').to_s
  end

  def product_line_total_discounted_value_net
    @doc.xpath('.//Productlines.Total_Discounted_Value_Net/text()').to_s
  end

  def activity_no
    @doc.xpath('.//Productlines.ACTIVITYNO/text()').to_s
  end

  def course_occurrence_no
    @doc.xpath('.//Productlines.COURSEOCCURRENCENO/text()').to_s
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

  def joining_instructions
    @doc.xpath('.//Activity.Joining_Instructions/text()').to_s
  end

  def requested_cancellation
    @doc.xpath('.//Productlines.Requested_Cancellation/text()').to_s
  end

  def name
    @doc.xpath('.//Productlines.Actual__x002F__Waiting_List_Delegates/text()').to_s
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

end
