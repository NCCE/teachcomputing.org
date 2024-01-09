Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "blog.teachcomputing.org",
      /\Ahttps?:\/\/(.+\.)?stem\.org\.uk\z/,
      "ncce.stem.ce-vm.local"

    resource(
      "*",
      headers: :any,
      methods: %i[get options head]
    )
  end
end
