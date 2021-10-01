class CacheInvalidator
  def initialize(resource:, identifier:)
    @resource = resource
    @identifier = identifier
    @namespace = 'curriculum'
    @schema = 'curriculum_schema'
  end

  def run
    Rails.cache.delete(@schema)
    Rails.cache.delete(resource_single_key, namespace: @namespace)
    Rails.cache.delete(resource_list_key, namespace: @namespace) if resource_list_cached?
  end

  private

    def resource_single_key
      "#{@resource}--#{@identifier}"
    end

    def resource_list_key
      "#{@resource}--all"
    end

    def resource_list_cached?
      @resource == 'key_stage'
    end
end
