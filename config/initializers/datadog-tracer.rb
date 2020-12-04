Datadog.configure do |c|
  c.use :rails, service_name: "teachcomputing_#{Rails.env}" unless Rails.env.development?
end
