york_region = HubRegion.find_or_create_by!(name: "York", order: 1)

york_hubs = [
  {address: "Heslington Ln, Heslington, York", postcode: "YO10 5DY"},
  {address: "Paragon St, York", postcode: "YO10 4AH"},
  {address: "Racecourse Road, Knavesmire Road, York", postcode: "YO23 1EX"}
]

york_hubs.each_with_index do |hub, index|
  Hub.find_or_create_by!(
    name: "Test Company #{index}",
    address: hub[:address],
    postcode: hub[:postcode],
    hub_region: york_region,
    subdeliverer_id: index + 1,
    phone: "01141234567",
    website: "http://example.com",
    twitter: "@hubtwitter",
    facebook: "hubfacebook",
    linkedin: "https://linkedin.com",
    instagram: "instahandle",
    satellite: false,
    satellite_info: "Some satellite info"
  )
end
