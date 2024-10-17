module Cms
  module DynamicComponents
    class FileLink
      attr_accessor :url, :filename, :size, :updated_at

      def initialize(url:, filename:, size:, updated_at:)
        @url = url
        @filename = filename
        @size = size
        @updated_at = updated_at
      end

      def extension
        ::File.extname(url).delete(".").upcase
      end

      def file_size
        size
      end

      def render
        CmsFileComponent.new(file: self)
      end
    end
  end
end
