class CacheInvalidator
  def initialize(resource:, identifier:)
    @resource = resource
    @identifier = identifier
    @namespace = "curriculum"
  end

  def run
    return clear_multiple_keys if multiple_keys?

    Rails.cache.delete(resource_single_key, namespace: @namespace)
    Rails.cache.delete(resource_list_key, namespace: @namespace) if resource_list_cached?
  end

  private

  def clear_multiple_keys
    @identifier.each do |identifier|
      Rails.cache.delete(resource_single_key(identifier), namespace: @namespace)
    end
  end

  def multiple_keys?
    @identifier.is_a? Array
  end

  def resource_single_key(identifier = nil)
    "#{@resource}--#{identifier || @identifier}"
  end

  def resource_list_key
    "#{@resource}--all"
  end

  def resource_list_cached?
    @resource == "key_stage"
  end
end
