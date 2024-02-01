class UpdateHubs < ActiveRecord::Migration[6.1]
  def up
    Rails.logger.info "Updating hubs for April 2023 (NCCE2)"
    Rails.logger.info "Deleting 6 hubs"
    Hub.find_by(name: "Nottingham North Satellite")&.destroy
    Hub.find_by(name: "Nottingham South Satellite")&.destroy
    Hub.find_by(name: "Lancashire")&.destroy
    Hub.find_by(name: "Oxfordshire and Buckinghamshire")&.destroy
    Hub.find_by(name: "London and Hertfordshire")&.destroy
    Hub.find_by(name: "West Berkshire Satellite")&.destroy

    Rails.logger.info "Creating 4 new hubs"
    north_west = HubRegion.find_by(name: "North West")
    unless Hub.find_by(name: "Lancashire Satellite")
      Hub.create(
        hub_region: north_west,
        name: "Lancashire Satellite",
        subdeliverer_id: "89318b0c-ecce-ed11-a7c6-002248c6b31a",
        address: "Priestley College, Loushers Lane, Warrington",
        postcode: "WA4 6RD",
        email: "teachcomputing@bca.warrington.ac.uk",
        phone: "01925 247688",
        website: "http://stem.warrington.ac.uk/computing.html",
        facebook: "ComputingHubMW",
        twitter: "ComputingHubMW"
      )
    end

    east_midlands = HubRegion.find_by(name: "East Midlands")
    unless Hub.find_by(name: "Leicestershire and Nottinghamshire")
      Hub.create(
        hub_region: east_midlands,
        name: "Leicestershire and Nottinghamshire",
        subdeliverer_id: "80823238-ecce-ed11-a7c6-002248c6b31a",
        address: "Beauchamp College, Ridge Way, Oadby",
        postcode: "LE2 5TP",
        phone: "01162 986234",
        email: "teachcomputing@lionhearttrust.org.uk",
        website: "https://tinyurl.com/computinghublei",
        twitter: "ComputingHubLEI"
      )
    end

    south_east = HubRegion.find_by(name: "South East")
    unless Hub.find_by(name: "Oxfordshire, Buckinghamshire and West Berkshire")
      Hub.create(
        hub_region: south_east,
        name: "Oxfordshire, Buckinghamshire and West Berkshire",
        subdeliverer_id: "3e81f571-ecce-ed11-a7c6-002248c6b31a",
        address: "St Clement Danes School, Chenies Road, Chorleywood",
        postcode: "WD3 6EW",
        email: "teachcomputing@scd.herts.sch.uk",
        phone: "01923 284169",
        website: "https://hubs.stclementdanes.herts.sch.uk/computing",
        twitter: "@ComputingHubBaO"
      )
    end

    east = HubRegion.find_by(name: "East of England")
    unless Hub.find_by(name: "London, Hertfordshire and Hampshire")
      Hub.create(
        hub_region: east,
        name: "London, Hertfordshire and Hampshire",
        subdeliverer_id: "5f4c768a-ecce-ed11-a7c6-002248c6b31a",
        address: "Sandringham School, The Ridgeway, St Albans",
        postcode: "AL4 9NX",
        phone: "01727 799560",
        email: "teachcomputing@albantsh.co.uk",
        website: "https://albantsa.co.uk/ncce-computing-hub/",
        facebook: "ComputingHubSAC",
        twitter: "ComputingHubSAC"
      )
    end
  end

  def down
    Rails.logger.info "Reverting hubs to March 2023 state"
    Rails.logger.info "Restoring 6 deleted hubs"
    east_midlands = HubRegion.find_by(name: "East Midlands")
    unless Hub.find_by(name: "Nottingham North Satellite")
      Hub.create(
        hub_region: east_midlands,
        name: "Nottingham North Satellite",
        subdeliverer_id: "6a240f87-d83e-eb11-a813-000d3a86d545",
        address: "",
        postcode: "NG22 8TH",
        email: "teachcomputing@allsaints.york.sch.uk",
        phone: "01904 545258",
        twitter: "@NCCEHubYork"
      )
    end

    unless Hub.find_by(name: "Nottingham South Satellite")
      Hub.create(
        hub_region: east_midlands,
        name: "Nottingham South Satellite",
        subdeliverer_id: "770aafb7-d83e-eb11-a813-000d3a86d545",
        address: "",
        postcode: "NG2 6LZ",
        email: "teachcomputing@lionhearttrust.org.uk",
        phone: "0116 298 6234",
        website: "https://tinyurl.com/computinghublei",
        twitter: "@ComputingHubLEI"
      )
    end

    north_west = HubRegion.find_by(name: "North West")
    unless Hub.find_by(name: "Lancashire")
      Hub.create(
        hub_region: north_west,
        name: "Lancashire",
        subdeliverer_id: "e1bc4a95-2a92-eb11-b1ac-000d3a86e2cc",
        address: "Bishop Rawstorne Church of England Academy, Highfield Road, Croston",
        postcode: "PR26 9HH",
        email: "teachcomputing@bishopr.co.uk",
        phone: "01772 600349",
        website: "https://www.lancashirecomputingHub.co.uk/",
        twitter: "computinghub",
        facebook: "lancashirecomputinghub"
      )
    end

    south_east = HubRegion.find_by(name: "South East")
    unless Hub.find_by(name: "Oxfordshire and Buckinghamshire")
      Hub.create(
        hub_region: south_east,
        name: "Oxfordshire and Buckinghamshire",
        subdeliverer_id: "b53f80f0-2c92-eb11-b1ac-000d3a86e2cc",
        address: "St Clement Danes School, Chenies Road, Chorleywood",
        postcode: "WD3 6EW",
        email: "teachcomputing@scd.herts.sch.uk",
        phone: "01923 284169",
        website: "https://hubs.stclementdanes.herts.sch.uk/computing",
        twitter: "@ComputingHubBaO"
      )
    end

    unless Hub.find_by(name: "West Berkshire Satellite")
      Hub.create(
        hub_region: south_east,
        name: "West Berkshire Satellite",
        subdeliverer_id: "5b33b8ea-851c-ed11-b83e-000d3a875606",
        address: "",
        postcode: "",
        email: "TeachComputing@stclementdanes.herts.sch.uk",
        phone: "01923 284169",
        latitude: 51.44,
        longitude: -1.16
      )
    end

    east = HubRegion.find_by(name: "East of England")
    unless Hub.find_by(name: "London and Hertfordshire")
      Hub.create(
        hub_region: east,
        name: "London and Hertfordshire",
        subdeliverer_id: "dbb5d74d-33de-e911-a812-000d3a86d6ce",
        address: "Sandringham School, The Ridgeway, St Albans",
        postcode: "AL4 9NX",
        email: "teachcomputing@albantsh.co.uk",
        phone: "01727 799560",
        website: "https://albantsa.co.uk/ncce-computing-hub/",
        twitter: "@ComputingHubSAC",
        facebook: "ComputingHubSAC"
      )
    end

    Rails.logger.info("Deleting 4 new hubs")
    Hub.find_by(name: "Lancashire Satellite")&.destroy
    Hub.find_by(name: "Leicestershire and Nottinghamshire")&.destroy
    Hub.find_by(name: "Oxfordshire, Buckinghamshire and West Berkshire")&.destroy
    Hub.find_by(name: "London, Hertfordshire and Hampshire")&.destroy
  end
end
