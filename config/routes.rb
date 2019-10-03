Rails.application.routes.draw do
  root to: 'pages#home', action: :home

  resources :achievements, only: %i[create destroy]

  namespace :activities do
    resources :redirects, only: [:show]
  end

  namespace 'admin' do
    resources :imports
  end

  resources :assessment_attempts

  get '/auth/callback', to: 'auth#callback', as: 'callback'

  namespace 'class_marker' do
    post '/webhook', to: 'webhooks#assessment', as: 'assessment_webhook'
  end

  resources :courses, path: '/courses', only: [:index]

  patch '/users/:id/teacher-reference-number', action: :teacher_reference_number, controller: 'user', as: :user_teacher_reference_number

  get '/certificate/:slug', action: :show, controller: 'programmes', as: :programme
  post '/certifcate/:slug/enrol', action: :create, controller: 'user_programme_enrolments', as: :user_programme_enrolment
  get '/certificate/:slug/complete', action: :complete, controller: 'programmes', as: :programme_complete
  get '/certificate/:slug/view-certificate', action: :certificate, controller: 'programmes', as: :programme_certificate

  get 'dashboard', action: :show, controller: 'dashboard'

  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/cs-accelerator', to: 'pages#static_programme_page', as: :cs_accelerator, defaults: { page_slug: 'cs-accelerator' }
  get '/primary-certificate', to: 'pages#static_programme_page', as: :primary, defaults: { page_slug: 'primary-certificate' },
                  constraints: ->(_request) { Programme.primary_certificate.enrollable? }
  get '/secondary-certificate', to: 'pages#static_programme_page', as: :secondary, defaults: { page_slug: 'secondary-certificate' },
                  constraints: ->(_request) { Programme.secondary_certificate.enrollable? }
  get '/accelerator', to: redirect('/cs-accelerator')
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/certification', to: 'pages#page', as: :certification, defaults: { page_slug: 'certification' }
  get '/get-involved', to: 'pages#page', as: :get_involved, defaults: { page_slug: 'get-involved' }
  get '/maintenance', to: 'pages#page', as: :maintenance, defaults: { page_slug: 'maintenance' }
  get '/logout', to: 'auth#logout', as: :logout
  get '/offer', to: 'pages#page', as: :offer, defaults: { page_slug: 'offer' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/resources', to: 'pages#page', as: :resources, defaults: { page_slug: 'resources' }
  get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/competition-terms-and-conditions', to: 'pages#page', as: :competition_terms_and_conditions, defaults: { page_slug: 'competition-terms-and-conditions' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/hubs', to: 'pages#page', as: :hubs, defaults: { page_slug: 'hubs' }
  get '/404', to: 'pages#exception', defaults: { format: 'html', status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
  get '/accessibility-statement', to: 'pages#page', as: :accessibility_statement, defaults: { page_slug: 'accessibility-statement' }

  scope '/news' do
    get '/', as: :news, to: redirect('https://blog.teachcomputing.org/tag/news')
    get '/a-level', to: redirect('https://blog.teachcomputing.org/a-level')
    get '/beta-launch', to: redirect('https://blog.teachcomputing.org/beta-launch')
    get '/women-in-stem', to: redirect('https://blog.teachcomputing.org/women-in-stem')
    get '/first-regional-delivery-network', to: redirect('https://blog.teachcomputing.org/first-regional-delivery-network')
  end

  scope '/press' do
    get '/', as: :press, to: redirect('https://blog.teachcomputing.org/tag/press')
    get '/simon-peyton-jones-chair-ncce', to: redirect('https://blog.teachcomputing.org/simon-peyton-jones-chair-ncce')
    get '/bt-rolls-royce-arm-back-ncce', to: redirect('https://blog.teachcomputing.org/bt-rolls-royce-arm-back-ncce')
  end

  get '/external/assets/ncce.css', to: 'asset_endpoint#css_endpoint', as: :css_endpoint

  require 'sidekiq/web'
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
    end
  end
  mount Sidekiq::Web, at: 'admin/sidekiq'
end
