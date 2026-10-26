# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# SCSS sources are compiled into app/assets/builds by cssbundling-rails (yarn build:css),
# so keep Propshaft from publishing the raw .scss files. Administrate's own SCSS is
# excluded too: its precompiled CSS is in the gem's app/assets/builds.
Rails.application.config.assets.excluded_paths << Rails.root.join("app/assets/stylesheets")
Rails.application.config.assets.excluded_paths << Administrate::Engine.root.join("app/assets/stylesheets")
