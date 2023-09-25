namespace :dev do
  desc 'Adds hub regions to database'
  task populate_hub_regions: :environment do
    regions = [
      ['East Midlands', 1],
      ['East of England', 2],
      ['London', 3],
      ['North East', 4],
      ['North West', 5],
      ['South East', 6],
      ['South West', 7],
      ['West Midlands', 8],
      ['Yorkshire and The Humber', 9],
    ]
    regions.each do |name, order|
      HubRegion.find_or_create_by(name: name, order: order)
    end
  end

  desc 'Adds hubs to database'
  task populate_hubs: :environment do
    Hub.destroy_all
    east_midlands = HubRegion.find_by(name: 'East Midlands')
    east_midlands_hubs = [
      { hub_name: 'Leicestershire, Nottinghamshire and Rutland',
        subdeliverer_id: 'c04b44d6-81e2-ed11-8846-002248c6b31a',
        address: 'Beauchamp College, Ridge Way, Oadby',
        postcode: 'LE2 5TP',
        email: 'teachcomputing@lionhearttrust.org.uk',
        phone: '01162 986234',
        website: 'https://tinyurl.com/computinghublei',
        twitter: '@ComputingHubLEI' },
      { hub_name: 'Lincolnshire',
        subdeliverer_id: 'f8e43c3e-3ed0-ea11-a813-000d3a86d545',
        address: "The Priory Academy LSST, Cross O'Cliff Hill, Lincoln",
        postcode: 'LN5 8PW',
        email: 'teachcomputing@prioryacademies.co.uk',
        phone: '01522 889297 Ext: 6369',
        website: 'https://www.lincolnshiretsa.co.uk/computinghub',
        twitter: '@lincstsa' },
      { hub_name: 'Milton Keynes and Northamptonshire',
        subdeliverer_id: 'd9fc0fa9-32de-e911-a812-000d3a86d6ce',
        address: 'Denbigh School, Burchard Crescent, Shenley Church End',
        postcode: 'MK5 6EX',
        email: 'teachcomputing@denbigh.net',
        phone: '01908 330578',
        website: 'https://computingmkn.org/',
        twitter: '@computinghubmkn',
        facebook: 'ComputingHubMKN' },
      { hub_name: 'Nottingham North Satellite',
        satellite: true,
        satellite_info: 'is managed by the York, East and South Yorkshire Computing Hub. Please contact the hub for details.',
        postcode: 'NG22 8TH',
        phone: '01904 545258',
        twitter: '@NCCEHubYork',
        email: 'TeachComputing@allsaints.york.sch.uk',
        subdeliverer_id: '6a240f87-d83e-eb11-a813-000d3a86d545' },
      { hub_name: 'Nottingham South Satellite',
        satellite: true,
        satellite_info: 'is managed by the Leicester and East Midlands Computing Hub, please contact the hub for details.',
        postcode: 'NG2 6LZ',
        phone: '0116 298 6234',
        twitter: '@ComputingHubLEI',
        website: 'https://tinyurl.com/computinghublei',
        email: 'teachcomputing@lionhearttrust.org.uk',
        subdeliverer_id: '770aafb7-d83e-eb11-a813-000d3a86d545' }
    ]
    insert_hubs(east_midlands_hubs, east_midlands)

    east_of_england = HubRegion.find_by(name: 'East of England')
    east_of_england_hubs = [
      { hub_name: 'Cambridge and Northamptonshire',
        subdeliverer_id: '47cccc6a-32de-e911-a812-000d3a86d6ce',
        address: 'Chesterton Community College, Gilbert Road, Cambridge',
        postcode: 'CB4 3NY',
        email: 'teachcomputing@ccc.tela.org.uk',
        phone: '01223 712150 (ext 136)',
        website: 'https://easternlearningalliance.org.uk/computing-hub/',
        facebook: 'profile.php?id=100068410816044',
        twitter: '@NCCECambs' },
      { hub_name: 'London and Hertfordshire',
        subdeliverer_id: 'dbb5d74d-33de-e911-a812-000d3a86d6ce',
        address: 'Sandringham School, The Ridgeway, St Albans',
        postcode: 'AL4 9NX',
        email: 'teachcomputing@albantsh.co.uk',
        phone: '01727 799560',
        website: 'https://albantsa.co.uk/ncce-computing-hub/',
        facebook: 'CompHubSAC',
        twitter: '@ComputingHubSAC' },
      { hub_name: 'London, Hertfordshire and Essex',
        subdeliverer_id: '28756140-33de-e911-a812-000d3a86d6ce',
        address: 'Saffron Walden County High School, Audley End Road, Saffron Walden',
        postcode: 'CB11 4UH',
        email: 'TeachComputing@swchs.net',
        phone: '01799 513030 (ext 1264)',
        website: 'https://www.saffronteachingschoolhub.net/page/?title=Computing+Hub+%2D+London%2C+Herts+%26amp%3B+Essex&pid=101',
        facebook: 'TeachComputingSWCHS',
        twitter: '@NCCESWCHS' },
      { hub_name: 'Norfolk',
        subdeliverer_id: 'a4350eaf-32de-e911-a812-000d3a86d6ce',
        address: 'Dereham Neatherd High School, Norwich Road, Dereham',
        postcode: 'NR20 3AX',
        email: 'teachcomputing@neatherd.org',
        phone: '01362 697981',
        website: 'https://teachcomputing.neatherd.org/',
        twitter: '@TeachCompNflk',
        facebook: 'TeachCompNflk' },
      { hub_name: 'Suffolk',
        subdeliverer_id: '68d76884-33de-e911-a812-000d3a86d6ce',
        address: 'West Suffolk College, Out Risbygate, Bury St Edmunds',
        postcode: 'IP33 3RL',
        phone: '01284 338749',
        website: 'https://www.wsc.ac.uk/schools/6643-suffolk-computer-hub',
        email: 'computerhub@wsc.ac.uk' }
    ]
    insert_hubs(east_of_england_hubs, east_of_england)

    london = HubRegion.find_by(name: 'London')
    london_hubs = [
      { hub_name: 'London and Essex',
        subdeliverer_id: 'bdb0ddba-2792-eb11-b1ac-000d3a86e2cc',
        address: 'Westcliffe School for Girls, Kenilworth Gardens, Westcliff-on-Sea',
        postcode: 'SS0 0BS',
        email: 'TeachComputing@setsa.info',
        phone: '01702 476026 (ext 326)',
        website: 'https://www.setsa.info/1550/computing-hub-1',
        twitter: '@cs_essex' },
      { hub_name: 'London, Surrey and West Sussex',
        subdeliverer_id: '4d2c34b0-2892-eb11-b1ac-000d3a86e2cc',
        address: 'Newstead Wood School, Avebury Road, Orpington',
        postcode: 'BR6 9SA',
        email: 'teachcomputing@newsteadwood.co.uk',
        phone: '01689 853626',
        twitter: '@teachcomp_se' }
    ]
    insert_hubs(london_hubs, london)

    north_east = HubRegion.find_by(name: 'North East')
    north_east_hubs = [
      { hub_name: 'Newcastle, Durham and East Cumbria',
        subdeliverer_id: 'd2eb5c28-2992-eb11-b1ac-000d3a86e2cc',
        address: 'Cardinal Hume Catholic School, Old Durham Road, Beacon Lough',
        postcode: 'NE9 6RZ',
        email: 'teachcomputing@chs.bwcet.com',
        phone: '0191 487 7638',
        facebook: 'CardinalCompHub',
        twitter: '@ComputingHubNE' },
      { hub_name: 'North East and Northumberland',
        subdeliverer_id: 'fcbf7a34-2992-eb11-b1ac-000d3a86e2cc',
        address: 'Kings Priory School, Huntington Place, Tynemouth',
        postcode: 'NE30 4RF',
        email: 'teachcomputing@kps.woodard.co.uk',
        phone: '01912 585995',
        twitter: '@NCCENorthEast' },
      { hub_name: 'Tees Valley and Durham',
        subdeliverer_id: '1ad8ca0d-2992-eb11-b1ac-000d3a86e2cc',
        address: 'Carmel College, The Headlands, Darlington',
        postcode: 'DL3 8RW',
        email: 'computinghub@carmel.bhcet.org.uk',
        phone: '01325 523428',
        twitter: '@computinghubTVD',
        facebook: 'computinghubTVD' }
    ]
    insert_hubs(north_east_hubs, north_east)

    north_west = HubRegion.find_by(name: 'North West')
    north_west_hubs = [
      { hub_name: 'Cheshire',
        subdeliverer_id: 'f69e187d-2a92-eb11-b1ac-000d3a86e2cc',
        address: 'The Fallibroome Trust, Priory Lane, Macclesfield, Cheshire',
        postcode: 'SK10 4AF',
        email: 'teachcomputing@fallibroometrust.com',
        website: 'https://cheshirecomputinghub.fallibroometrust.com/',
        phone: '01625 813512',
        twitter: 'https://twitter.com/ComputingHubFT' },
      { hub_name: 'Cumbria Satellite',
        satellite: true,
        satellite_info: 'is managed by the Newcastle, Durham and East Cumbria Computing Hub, please contact the hub for details',
        email: 'teachcomputing@chs.bwcet.com',
        phone: '0191 487 7638',
        twitter: '@ComputingHubNE',
        postcode: 'CA12 5XQ',
        facebook: 'CardinalCompHub',
        subdeliverer_id: '7218e040-2992-eb11-b1ac-000d3a86e2cc' },
      { hub_name: 'Greater Manchester',
        subdeliverer_id: '985d4289-2a92-eb11-b1ac-000d3a86e2cc',
        address: 'Tameside College, Beaufort Road, Ashton-under-Lyne',
        postcode: 'OL6 6NX',
        email: 'manchester-ncce@tameside.ac.uk',
        twitter: '@ComputingHubGM' },
      { hub_name: 'Lancashire',
        subdeliverer_id: 'e1bc4a95-2a92-eb11-b1ac-000d3a86e2cc',
        address: 'Bishop Rawstorne Church of England Academy, Highfield Road, Croston',
        postcode: 'PR26 9HH',
        email: 'TeachComputing@bishopr.co.uk',
        phone: '01772 600349',
        website: 'https://www.bishoprts.co.uk/lancashirecomputinghub',
        twitter: '@ComputingHub' },
      { hub_name: 'Warrington and Merseyside',
        subdeliverer_id: '5bde57a1-2a92-eb11-b1ac-000d3a86e2cc',
        address: 'Priestley College, Loushers Lane, Warrington',
        postcode: 'WA4 6RD',
        email: 'teachcomputing@bca.warrington.ac.uk',
        phone: '01925 247688',
        website: 'http://stem.warrington.ac.uk/computing.html',
        facebook: 'ComputingHubMW',
        twitter: '@ComputingHubMW' }
    ]
    insert_hubs(north_west_hubs, north_west)

    south_east = HubRegion.find_by(name: 'South East')
    south_east_hubs = [
      { hub_name: 'Dartford and East Sussex',
        subdeliverer_id: 'cb85417e-32de-e911-a812-000d3a86d6ce',
        address: 'Dartford Grammar School, West Hill, Dartford',
        postcode: 'DA1 2HW',
        email: 'teachcomputing@dartfordgrammarschool.org.uk',
        phone: '01322 223039 (ext 161)',
        website: 'https://www.dartfordgrammarschool.org.uk/Computing-Hub/',
        twitter: '@NcceSouthEast' },
      { hub_name: 'London and Home Counties',
        subdeliverer_id: 'c80b9be2-2c92-eb11-b1ac-000d3a86e2cc',
        address: 'Langley Grammar School, Reddington Drive, Langley',
        postcode: 'SL3 7QS',
        email: 'TeachComputing@lgs.slough.sch.uk',
        phone: '01753 598300',
        twitter: '@CompHubLGS' },
      { hub_name: 'Maidstone and Kent',
        subdeliverer_id: 'fe801691-32de-e911-a812-000d3a86d6ce',
        address: 'Maidstone Grammar School for Girls, Buckland Road, Maidstone',
        postcode: 'ME16 0SF',
        email: 'teachcomputing@mggs.org',
        phone: '01662 752103',
        website: 'https://www.mggs.org/our-story/computing-hub',
        facebook: 'comphubkent',
        twitter: '@CompHubKent' },
      { hub_name: 'Oxfordshire and Buckinghamshire',
        subdeliverer_id: 'b53f80f0-2c92-eb11-b1ac-000d3a86e2cc',
        address: 'St Clements Danes School, Chenies Road, Chorleywood',
        postcode: 'WD3 6EW',
        email: 'teachcomputing@stclementdanes.herts.sch.uk',
        phone: '01923 284169',
        website: 'https://www.hertsandbuckstsa.co.uk/1309/computer-hub',
        twitter: '@ComputingHubBaO' },
      { hub_name: 'Surrey', subdeliverer_id: '79f2fb09-3ed0-ea11-a813-000d3a86d545',
        address: 'Woking High School, Morton Road, Horsell',
        postcode: 'GU21 4TJ',
        email: 'TeachComputing@Wokinghigh.Surrey.sch.uk',
        phone: '01483 888447 (ext 204)',
        facebook: 'wokinghigh.ncce',
        twitter: '@HubWHSSurrey' },
      { hub_name: 'West Berkshire and Hampshire',
        subdeliverer_id: 'd37b5922-33de-e911-a812-000d3a86d6ce',
        address: 'Park House School, Andover Road, Newbury',
        postcode: 'RG14 6NQ',
        email: 'teachcomputing@parkhouseschool.org',
        phone: '01635 573911',
        website: 'www.parkhousehub.org',
        facebook: 'HubPHSNewbury',
        twitter: '@HubPHSNewbury' },
      { hub_name: 'West Sussex and Hampshire',
        subdeliverer_id: 'cc21dbc3-3dd0-ea11-a813-000d3a86d545',
        address: 'Bohunt School, Longmoor Road, Liphook',
        postcode: 'GU30 7NY',
        email: 'TeachComputing@bohunt.hants.sch.uk',
        twitter: '@BohuntNCCEHub',
        facebook: 'Teach-Computing-West-Sussex-and-Hampshire-331954548255089',
        phone: '01428 724324' }
    ]
    insert_hubs(south_east_hubs, south_east)

    south_west = HubRegion.find_by(name: 'South West')
    south_west_hubs = [
      { hub_name: 'Cornwall & Plymouth',
        subdeliverer_id: '2bca0e7e-33de-e911-a812-000d3a86d6ce',
        address: 'Truro and Penwith College, College Road, Truro',
        postcode: 'TR1 3XX',
        phone: '01872 308463',
        twitter: '@NCCECornwalPlym',
        facebook: 'CornwallPlymouthComputingHub',
        email: 'teachcomputing@truro-penwith.ac.uk' },
      { hub_name: 'Devon',
        subdeliverer_id: '34c55ebb-32de-e911-a812-000d3a86d6ce',
        address: 'Exeter Mathematics School, Rougemont House, Castle Road',
        postcode: 'EX4 3PU',
        email: 'TeachComputing@exeterms.ac.uk',
        phone: '01392 429020',
        website: 'https://www.exetermathematicsschool.ac.uk/for-teachers/teachers-computer-science/',
        facebook: 'exetermathematicsschool',
        twitter: '@ComputingHubDev' },
      { hub_name: 'Gloucestershire, Wiltshire and North Somerset',
        subdeliverer_id: '845ce483-2d92-eb11-b1ac-000d3a86e2cc',
        address: "Pate's Grammar School, Princess Elizabeth Way, Cheltenham",
        postcode: 'GL51 0HG',
        email: 'teachcomputing@odysseyts.org',
        phone: '01242 220684',
        website: 'https://adfecto.org.uk/',
        facebook: 'Odysseycomputinghub',
        twitter: '@ComputingHubOTS' },
      { hub_name: 'Somerset', subdeliverer_id: '56a1f25f-33de-e911-a812-000d3a86d6ce',
        address: 'The Castle School, Wellington Road, Taunton',
        postcode: 'TA1 5AU',
        email: 'teachcomputing@castle.somerset.sch.uk',
        phone: '01823 274073',
        twitter: '@ComputingHubSom' }
    ]
    insert_hubs(south_west_hubs, south_west)

    west_midlands = HubRegion.find_by(name: 'West Midlands')
    west_midlands_hubs = [
      { hub_name: 'Birmingham and West Midlands',
        subdeliverer_id: '44c64140-32de-e911-a812-000d3a86d6ce',
        address: 'Bishop Challoner Catholic College, Institute Road, Kings Heath',
        postcode: 'B14 7EG',
        email: 'teachcomputing@bishopchalloner.bham.sch.uk',
        phone: '01214 416128',
        website: 'https://www.bctsa.org/583/computing-hub',
        facebook: 'BCComputingHub',
        twitter: '@BCComputingHub' },
      { hub_name: 'Stoke-on-Trent, Staffordshire and Derbyshire',
        subdeliverer_id: '5e12c570-32de-e911-a812-000d3a86d6ce',
        address: 'City of Stoke-on-Trent 6th Form College, Leek Road, Stoke-on-Trent',
        postcode: 'ST4 2RU',
        email: 'TeachComputing@potteries.ac.uk',
        phone: '01782 854222',
        twitter: '@ComputingHubSOT' },
      { hub_name: 'West Midlands', subdeliverer_id: '1c90046c-33de-e911-a812-000d3a86d6ce',
        address: 'The Chase, Geraldine Road, Malvern',
        postcode: 'WR14 3NZ',
        email: 'TeachComputing@chase.worcs.sch.uk',
        phone: '01684 218479',
        facebook: 'TCComputingHub',
        twitter: '@TC_ComputingHub' }
    ]
    insert_hubs(west_midlands_hubs, west_midlands)

    yorks_and_humber = HubRegion.find_by(name: 'Yorkshire and The Humber')
    yorks_and_humber_hubs = [
      { hub_name: 'North Yorkshire, Leeds and Wakefield',
        subdeliverer_id: '2ca6530e-c392-eb11-b1ac-000d3a870eed',
        address: 'Harrogate Grammar School, Arthurs Avenue, Harrogate',
        postcode: 'HG2 0DZ',
        email: 'TeachComputing@rklt.co.uk',
        phone: '01423 531127',
        twitter: '@CompHubYorks' },
      { hub_name: 'West Yorkshire',
        subdeliverer_id: '4ae339bf-c492-eb11-b1ac-000d3a870eed',
        address: 'Bingley Grammar School, Keighley Road, Bingley',
        postcode: 'BD16 2RS',
        email: 'teachcomputing@bingleygrammar.org',
        website: 'https://www.bingleygrammar.org/about/computing-hub/',
        phone: '01274 807700',
        twitter: '@ComputingHubBIY' },
      { hub_name: 'York, East and South Yorkshire',
        subdeliverer_id: '11744ecb-c492-eb11-b1ac-000d3a870eed',
        address: 'All Saints, Mill Mount Lane, York',
        postcode: 'YO24 1BJ',
        phone: '01904 545258',
        email: 'TeachComputing@allsaints.york.sch.uk',
        twitter: '@NCCEHubYork' }
    ]
    insert_hubs(yorks_and_humber_hubs, yorks_and_humber)
  end

  def insert_hubs(hubs, region)
    hubs.each do |hub|
      email = hub[:email].present? ? hub[:email].downcase : nil
      Hub.create(
        name: hub[:hub_name],
        hub_region: region,
        subdeliverer_id: hub[:subdeliverer_id],
        address: hub[:address],
        postcode: hub[:postcode],
        email: email,
        phone: hub[:phone],
        website: hub[:website],
        twitter: hub[:twitter],
        facebook: hub[:facebook],
        satellite: hub[:satellite],
        satellite_info: hub[:satellite_info],
      )
    end
  end
end
