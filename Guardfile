# configures the guard gem

guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w[erb haml slim])
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      "#{rspec.spec_dir}/requests/#{m[1]}"
    ]
  end

  # Rails config changes
  watch(rails.spec_helper) { rspec.spec_dir }
  # watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller) { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs) { |m| rspec.spec.call(m[0].sub("app/", "").sub(".erb", "").to_s) }
  # watch(rails.layouts) do |m|
  #   puts "rails.layouts #{m.inspect}"
  #   rspec.spec.call("views/layouts//#{m[1]}")
  # end

  # Background jobs
  watch(%r{^app/jobs/(.+)\.rb$}) { |m| "spec/jobs/#{m[1]}_spec.rb" }
  # FactoryBot factories
  begin
    require "active_support/inflector"
    watch(%r{^spec/factories/(.+)\.rb$}) do |m|
      ["app/models/#{m[1].singularize}.rb", "spec/models/#{m[1].singularize}_spec.rb"]
    end
  rescue LoadError # rubocop:disable Lint/SuppressedException
  end

  watch(%r{^app/services/(.+)/(.+)\.rb$}) do |m|
    ["#{rspec.spec_dir}/services/#{m[1]}/#{m[2]}_spec.rb"]
  end

  watch(%r{^lib/(.+)\.rb$}) do |m|
    ["#{rspec.spec_dir}/lib/#{m[1]}_spec.rb"]
  end

  # rake
  watch(%r{^lib/tasks/(.+)\.rake$}) do |m|
    ["#{rspec.spec_dir}/lib/tasks/#{m[1]}_spec.rb"]
  end
end
