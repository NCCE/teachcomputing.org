Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://*.teachcomputing.org'

    resource(
      '*',
      headers: :any,
      methods: [:get, :options]
    )
  end
end