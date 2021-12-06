primary_certificate = Programme.primary_certificate

puts 'Creating Programme Activity Groupings for Primary certificate'

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Online courses') do |programme_activity_group|
  programme_activity_group.sort_key = 1
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Face to face or remote courses') do |programme_activity_group|
  programme_activity_group.sort_key = 2
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'Contribute to an online discussion') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'develop your teaching practice') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end

primary_certificate.programme_activity_groupings.find_or_create_by(title: 'develop computing in your community') do |programme_activity_group|
  programme_activity_group.sort_key = 3
  programme_activity_group.required_for_completion = 1
  programme_activity_group.programme_id = primary_certificate.id
end
