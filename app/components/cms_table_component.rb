# frozen_string_literal: true

class CmsTableComponent < ViewComponent::Base
  def initialize(resource, key)
    @resource = resource
    @key = key.to_sym
  end

  def table_data
    @resource.attributes[@key].map do |record|
      record_fields.map { record[:attributes][_1.to_sym] }
    end
  end

  def record_fields
    @resource.attribute_mapping(@key)[:fields].collect { |field| field[:attribute] }
  end

  def table_columns
    record_fields.map { _1.underscore.humanize }
  end

  def render?
    @resource.attribute_mapping(@key).present?
  end
end
