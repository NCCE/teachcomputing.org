namespace :review_app do
    # This task is invoked as a postdeploy script in app.json, which is triggered when a new Heroku review app is created
    # (once the 'release' commands defined in Procfile have been executed)
    #
    # - Updates relevant ENV vars
    # - Migrates the database
  
    task :setup do
      Rake::Task["review_app:update_heroku_app_env_vars"].invoke
      Rake::Task["review_app:migrate_database"].invoke
    end
  
    task update_heroku_app_env_vars: :system do
      heroku_token = ENV["HEROKU_PLATFORM_TOKEN"]
      heroku = PlatformAPI.connect_oauth(heroku_token)
      heroku_app_name = ENV["HEROKU_APP_NAME"]
      heroku.config_var.update(heroku_app_name, "STEM_OAUTH_CALLBACK_URL" => "#{heroku_app_name}.herokuapp.com/auth/callback")
      
    end
  
    task :migrate_database do
      system "bundle exec rake db:migrate"
    end
  end