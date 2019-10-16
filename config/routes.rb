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
  get '/certificate/:slug/view-certificate', action: :certificate, controller: 'programmes', as: :programme_certificate
  get '/certificate/cs-accelerator/diagnostic/:id', to: 'diagnostics/cs_accelerator#show', as: :cs_accelerator_diagnostic
  get '/certificate/primary-certificate/diagnostic/:id', to: 'diagnostics/primary_certificate#show', as: :primary_certificate_diagnostic
  put '/certificate/primary-certificate/diagnostic/:id', to: 'diagnostics/primary_certificate#update', as: :update_primary_certificate_diagnostic

  namespace 'class_marker' do
    post '/webhook', to: 'webhooks#assessment', as: 'assessment_webhook'
  end

  resources :courses, path: '/courses', only: [:index]

  get 'dashboard', action: :show, controller: 'dashboard'

  patch '/users/:id/teacher-reference-number', action: :teacher_reference_number, controller: 'user', as: :user_teacher_reference_number

  get '/404', to: 'pages#exception', defaults: { format: 'html', status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/accelerator', to: redirect('/cs-accelerator')
  get '/accessibility-statement', to: 'pages#page', as: :accessibility_statement, defaults: { page_slug: 'accessibility-statement' }
  get '/auth/callback', to: 'auth#callback', as: 'callback'
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/certification', to: 'pages#page', as: :certification, defaults: { page_slug: 'certification' }
  get '/competition-terms-and-conditions', to: 'pages#page', as: :competition_terms_and_conditions, defaults: { page_slug: 'competition-terms-and-conditions' }
  get '/cs-accelerator', to: 'pages#static_programme_page', as: :cs_accelerator, defaults: { page_slug: 'cs-accelerator' }
  get '/external/assets/ncce.css', to: 'asset_endpoint#css_endpoint', as: :css_endpoint
  get '/get-involved', to: 'pages#page', as: :get_involved, defaults: { page_slug: 'get-involved' }
  get '/hubs', to: 'pages#page', as: :hubs, defaults: { page_slug: 'hubs' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/maintenance', to: 'pages#page', as: :maintenance, defaults: { page_slug: 'maintenance' }
  get '/offer', to: 'pages#page', as: :offer, defaults: { page_slug: 'offer' }
  get '/primary-certificate', to: 'pages#static_programme_page', as: :primary, defaults: { page_slug: 'primary-certificate' },
    constraints: ->(_request) { Programme.primary_certificate.enrollable? }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/resources', to: 'pages#page', as: :resources, defaults: { page_slug: 'resources' }
  get '/secondary-certificate', to: 'pages#static_programme_page', as: :secondary, defaults: { page_slug: 'secondary-certificate' },
    constraints: ->(_request) { Programme.secondary_certificate.enrollable? }
  get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }

  require 'sidekiq/web'
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
    end
  end
  mount Sidekiq::Web, at: 'admin/sidekiq'
end
