Rails.application.routes.draw do
  root to: 'pages#home', action: :home

  resources :achievements, only: %i[create destroy]

  namespace 'admin' do
    resources :imports
  end

  resources :assessment_attempts

  get '/certificate/:slug', action: :show, controller: 'programmes', as: :programme
  post '/certifcate/:slug/enrol', action: :create, controller: 'user_programme_enrolments', as: :user_programme_enrolment
  get '/certificate/:slug/complete', action: :complete, controller: 'programmes', as: :programme_complete
  get '/certificate/:slug/pending', action: :pending, controller: 'programmes', as: :programme_pending
  get '/certificate/:slug/view-certificate', action: :certificate, controller: 'programmes', as: :programme_certificate
  get '/certificate/cs-accelerator/diagnostic/:id', to: 'diagnostics/cs_accelerator#show', as: :cs_accelerator_diagnostic
  get '/certificate/primary-certificate/questionnaire/:id', to: 'diagnostics/primary_certificate#show', as: :primary_certificate_diagnostic
  put '/certificate/primary-certificate/questionnaire/:id', to: 'diagnostics/primary_certificate#update', as: :update_primary_certificate_diagnostic

  namespace 'class_marker' do
    post '/webhook', to: 'webhooks#assessment', as: 'assessment_webhook'
  end

  get '/courses', action: :index, controller: 'courses', as: 'courses'
  get '/courses/:id(/:name)', action: :show, controller: 'courses', as: 'course'

  get 'dashboard', action: :show, controller: 'dashboard'

  get '/resources', action: :index, controller: 'resources'
  get '/resources/*redirect_url', action: :show, controller: 'resources', as: 'resources_redirect', format: false

  patch '/users/:id/teacher-reference-number', action: :teacher_reference_number, controller: 'user', as: :user_teacher_reference_number

  get '/404', to: 'pages#exception', defaults: { format: 'html', status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/accelerator', to: redirect('/cs-accelerator')
  get '/accessibility-statement', to: 'pages#page', as: :accessibility_statement, defaults: { page_slug: 'accessibility-statement' }
  get '/auth/stem', to: redirect('/login')
  get '/auth/callback', to: 'auth#callback', as: 'callback'
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/careers-week', to: 'pages#page', as: :careers_week, defaults: { page_slug: 'careers-week' }
  get '/cms/:page_slug', action: :cms_page, controller: :cms, as: :cms_page, defaults: { page_slug: 'bursary' }, constraints: { page_slug: /(hubs|bursary)/ }
  get '/cms/:page_slug/refresh', action: :clear_page_cache, controller: :cms, as: :clear_page_cache, defaults: { page_slug: 'bursary' }, constraints: { page_slug: /(hubs|bursary)/ }
  get '/competition-terms-and-conditions', to: 'pages#page', as: :competition_terms_and_conditions, defaults: { page_slug: 'competition-terms-and-conditions' }
  get '/cs-accelerator', to: 'pages#static_programme_page', as: :cs_accelerator, defaults: { page_slug: 'cs-accelerator' }
  get '/external/assets/ncce.css', to: 'asset_endpoint#css_endpoint', as: :css_endpoint
  get '/get-involved', to: 'pages#page', as: :get_involved, defaults: { page_slug: 'get-involved' }
  get '/hero-demo', to: 'pages#page', as: :hero_demo, defaults: { page_slug: 'hero-demo' }
  get '/home-teaching/:page_slug', to: 'cms#cms_page', as: :cms_home_teaching_page, defaults: { page_slug: 'key-stage-1' }, constraints: { page_slug: /(key-stage-1|key-stage-2|key-stage-3|key-stage-4)/ }
  get '/home-teaching/:page_slug/refresh', to: 'cms#clear_page_cache', as: :clear_home_teaching_page_cache, defaults: { page_slug: 'key-stage-1' }, constraints: { page_slug: /(key-stage-1|key-stage-2|key-stage-3|key-stage-4)/ }
  get '/hubs', to: 'pages#page', as: :hubs, defaults: { page_slug: 'hubs' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/maintenance', to: 'pages#page', as: :maintenance, defaults: { page_slug: 'maintenance' }
  get '/primary-certificate', to: 'pages#static_programme_page', as: :primary, defaults: { page_slug: 'primary-certificate' },
    constraints: ->(_request) { Programme.primary_certificate.enrollable? }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/secondary-certificate', to: 'pages#static_programme_page', as: :secondary, defaults: { page_slug: 'secondary-certificate' },
    constraints: ->(_request) { Programme.secondary_certificate.enrollable? }
    get '/secondary-teachers', to: 'landing_pages#secondary_teachers', as: :secondary_teachers, defaults: { slug: 'cs-accelerator' }
    get '/primary-teachers', to: 'landing_pages#primary_teachers', as: :primary_teachers, defaults: { slug: 'primary-certificate' }
    get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/trailer-demo', to: 'pages#page', defaults: { page_slug: 'trailer-demo' }
  get '/welcome', to: 'welcome#show', as: :welcome


  require 'sidekiq/web'
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
    end
  end
  mount Sidekiq::Web, at: 'admin/sidekiq'
end
