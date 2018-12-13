require('nokogiri')

class CourseOccurrenceFee
  def initialize(doc)
    @doc = doc
  end

  def fee_category
    @doc.xpath('./Fee.Fee_Category/text()').to_s
  end

  def fee
    @doc.xpath('./Fee.Fee/text()').to_s
  end

  def vat
    @doc.xpath('./Activity.VAT/text()').to_s
  end

  def delegate_fee
    @doc.xpath('./Activity.Delegate_Fee_Ex_VAT/text()').to_s
  end

  def delegate_fee_Category
    @doc.xpath('./Activity.Delegate_Fee_Category/text()').to_s
  end

  def costs_no
    @doc.xpath('./Fee.COSTSNO/text()').to_s
  end
end
