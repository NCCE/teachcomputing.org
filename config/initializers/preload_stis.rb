unless Rails.application.config.eager_load
  Rails.application.config.to_prepare do
    Rails.autoloaders.main.eager_load_dir("#{Rails.root}/app/models/enrichment_groupings")
    Rails.autoloaders.main.eager_load_dir("#{Rails.root}/app/models/programme_activity_groupings")
    Rails.autoloaders.main.eager_load_dir("#{Rails.root}/app/models/programmes")
  end
end
