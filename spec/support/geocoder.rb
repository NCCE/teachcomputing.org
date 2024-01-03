Geocoder.configure(lookup: :test, ip_lookup: :test)
Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'coordinates' => [53.4000000, -1.500000],
      'address' => 'Sheffield',
      'state' => 'South Yorkshire',
      'country' => 'United Kingdom',
      'country_code' => 'UK',
      'address_components' => [
        {
          "long_name" => "York",
          "short_name" => "York",
          "types" => ["postal_town"]
        },
      ]
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  'invalid', []
)
