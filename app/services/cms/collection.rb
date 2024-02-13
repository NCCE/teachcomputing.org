module Cms
  class Collection
    attr_accessor :resources, :page, :page_size, :page_number, :total_records

    def initialize(resources:, page:, page_size:, page_number:, total_records:)
      @resources = resources
      @page = page
      @page_size = page_size
      @page_number = page_number
      @total_records = total_records
    end
  end

end
