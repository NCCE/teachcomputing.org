namespace :hubs do
  desc 'Adds hub regions to database'
  task populate_regions: :environment do
    regions = [['North East', 1],
            ['North West', 2],
            ['Yorkshire and The Humber', 3],
            ['East Midlands', 4],
            ['West Midlands', 5],
            ['East of England', 6],
            ['South West', 7],
            ['London', 8],
            ['South East', 9]]
    regions.each do |name, order|
      HubRegion.find_or_create_by(name: name, order: order)
    end
  end
end
