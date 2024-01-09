class HubsIndex
  def initialize(location: nil)
    @location = location
  end

  def hub_regions
    return nil if @location.present?

    HubRegion.order(:order).includes(:hubs)
  end

  def current_location
    @location
  end

  def sorted_hubs
    return nil unless @location.present? && geocoded_search_location.present?

    Hub.near(geocoded_search_location.coordinates, 500)
  end

  def formatted_address
    @formatted_address ||= Geocoding.format_address(geocoded_location: geocoded_search_location)
  end

  private

  def geocoded_search_location
    return nil unless @location.present?
    return @geocoded_search_location if defined? @geocoded_search_location

    @geocoded_search_location = Geocoder.search(@location, params: {region: "GB"}).first
  end
end
