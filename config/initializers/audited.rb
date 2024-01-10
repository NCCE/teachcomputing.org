require "audited"

Audited::Railtie.initializers.each(&:run)

Rails.application.reloader.to_prepare do
  Audited.config do |config|
    config.audit_class = "SupportAudit"
  end
end
