class Geocoding
  class << self
    def format_address(geocoded_location:)
      return nil unless geocoded_location.present?

      town_components = geocoded_location&.address_components&.select do |c|
        c["types"].include?("postal_town")
      end
      if town_components&.any?
        town_components.first["long_name"]
      else
        geocoded_location&.formatted_address
      end
    end
  end
end
