Rails.application.config.to_prepare do
  ViewComponent::Base.include Webpacker::Helper
end
