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

    def next_page
      return nil if @page >= @page_number
      @page + 1
    end

    def previous_page
      return nil if @page == 1
      return @page_number if @page > @page_number
      @page - 1
    end
  end
end
