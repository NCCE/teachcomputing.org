Rails.application.routes.draw do
  Healthcheck.routes(self)
  root to: 'pages#home', action: :home

  resources :achievements, only: %i[create destroy]
  namespace :admin do
    root to: 'pathways#index'
    resources :badges
    resources :activities
    resources :pathways
    resources :pathway_activities
    resources :hubs
    resources :hub_regions
    resources :support_audits, only: %i[index show update edit]
    resources :users, only: %i[index create show edit perform_sync perform_reset update] do
      get '/perform_sync/:user_id', to: 'users#perform_sync', as: :perform_sync
      get '/perform_reset/:user_id', to: 'users#perform_reset_tests', as: :perform_reset
    end
    resources :user_programme_enrolments, only: %i[index show]
    resources :achievements, only: %i[index show]
    resources :assessment_attempts, only: %i[index show]
    resources :assessment_attempt_transition
  end

  namespace :api do
    delete '/cache', to: 'cache#destroy'
    get '/users', to: 'users#show'
    delete '/users/forget', to: 'users#forget'
    resources :users, only: %i[] do
      resources :achievements, only: %i[create] do
        post 'complete', action: :complete
      end
    end
    resources :activities, only: %i[index]
    resources :user_programme_enrolments, only: %i[show] do
      resources :activities, only: %i[index]
      post '/complete', action: :complete
      post '/enrolled', action: :enrolled
      post '/flag', action: :flag
    end
  end

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'admin/sidekiq'

  resources :assessment_attempts, only: %i[create]

  namespace 'certificates', path: 'certificate', as: '' do
    resource 'primary_certificate', controller: 'primary_certificate', path: 'primary-certificate', only: %i[show] do
      get '/complete', action: :complete, as: :complete
      get '/pending', action: :pending, as: :pending
      get '/view-certificate', action: :show, controller: 'certificate', as: :certificate,
                               defaults: { slug: 'primary-certificate' }
      post '/enrol', action: :create, controller: '/user_programme_enrolments', as: :enrol
      put '/pathway', action: :update, controller: 'primary_certificate/user_programme_pathway', as: :update_user_pathway
    end

    resource 'secondary_certificate', controller: 'secondary_certificate', path: 'secondary-certificate',
                                      only: %i[show] do
      get '/complete', action: :complete, as: :complete
      get '/pending', action: :pending, as: :pending
      get '/view-certificate', action: :show, controller: 'certificate', as: :certificate,
                               defaults: { slug: 'secondary-certificate' }
      post '/enrol', action: :create, controller: '/user_programme_enrolments', as: :enrol
    end

    resource 'cs_accelerator', controller: 'cs_accelerator', path: 'cs-accelerator', only: %i[show],
                               as: :cs_accelerator_certificate do
      get '/complete', action: :complete, as: :complete
      get '/pending', action: :pending, as: :pending
      get '/questionnaire/:id', to: '/diagnostics/cs_accelerator#show', as: :diagnostic
      put '/questionnaire/:id', to: '/diagnostics/cs_accelerator#update', as: :update_diagnostic
      get '/class_marker_diagnostic/:id', to: '/diagnostics/class_marker/cs_accelerator#show',
                                          as: :class_marker_diagnostic
      get '/view-certificate', action: :show, controller: 'certificate', as: :certificate,
                               defaults: { slug: 'cs-accelerator' }
      post '/enrol', action: :create, controller: '/user_programme_enrolments', as: :enrol
      get '/unenrol/:id', action: :destroy, controller: '/user_programme_enrolments', as: :unenrol
      put '/pathway', action: :update, controller: 'cs_accelerator/user_programme_pathway', as: :update_user_pathway
    end

    namespace 'cs_accelerator' do
      resource 'auto_enrolment', only: [] do
        get '/unenroll', action: :destroy
      end
    end
  end

  namespace 'class_marker' do
    post '/webhook', to: 'webhooks#assessment', as: 'assessment_webhook'
  end

  resource :feedback, only: %i[create]
  resources :hubs, only: %i[index]
  resources :downloads, only: %i[create]

  get '/bursary', to: redirect('/funding', status: 302)
  get '/courses', action: :index, controller: 'courses', as: 'courses'
  get '/courses/filter', action: :filter, controller: 'courses', as: 'course_filter'
  get '/courses/hubs/:hub_id', action: :index, controller: 'courses', as: 'hub'
  get '/courses/:id(/:name)', action: :show, controller: 'courses', as: 'course'

  get '/curriculum', to: 'curriculum/key_stages#index', as: :curriculum_key_stages
  get '/curriculum/:key_stage_slug', to: 'curriculum/key_stages#show', as: :curriculum_key_stage_units
  get '/curriculum/:key_stage_slug/:unit_slug', to: 'curriculum/units#show', as: :curriculum_key_stage_unit
  get '/curriculum/:key_stage_slug/:unit_slug/:lesson_slug', to: 'curriculum/lessons#show',
                                                             as: :curriculum_key_stage_unit_lesson
  post '/curriculum/rating/units/:polarity/:id/:user_id', to: 'curriculum/units#rate', as: :create_curriculum_unit_rating
  post '/curriculum/rating/comment', to: 'curriculum/units#comment', as: :update_curriculum_unit_rating
  post '/curriculum/rating/choices', to: 'curriculum/units#choices', as: :update_curriculum_unit_rating_choices
  post '/curriculum/rating/lessons/:polarity/:id/:user_id', to: 'curriculum/lessons#rate', as: :create_curriculum_lesson_rating
  post '/curriculum/rating/comment', to: 'curriculum/lessons#comment', as: :update_curriculum_lesson_rating
  post '/curriculum/rating/choices', to: 'curriculum/lessons#choices', as: :update_curriculum_lesson_rating_choices

  get 'dashboard', action: :show, controller: 'dashboard'

  namespace 'dynamics' do
    post '/webhook', to: 'webhooks#user', as: 'user_webhook'
  end

  get '/futurelearn/lti/:fl_id', to: 'future_learn/lti#show', as: 'futurelearn_lti'
  patch '/users/:id/teacher-reference-number', action: :teacher_reference_number, controller: 'user',
                                               as: :user_teacher_reference_number

  get '/404', to: 'pages#exception', defaults: { status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/accelerator', to: redirect('/cs-accelerator')
  get '/accessibility-statement', to: 'pages#page', as: :accessibility_statement,
                                  defaults: { page_slug: 'accessibility-statement' }
  get '/auth/stem', to: redirect('/login')
  get '/auth/callback', to: 'auth#callback', as: 'callback'
  get '/careers', to: 'pages#page', as: :careers_week, defaults: { page_slug: 'careers-week' }
  get '/careers-week', to: redirect('/careers')
  get '/competition-terms-and-conditions', to: 'pages#page', as: :competition_terms_and_conditions,
                                           defaults: { page_slug: 'competition-terms-and-conditions' }
  get '/cs-accelerator', to: 'pages#static_programme_page', as: :cs_accelerator,
                         defaults: { page_slug: 'cs-accelerator' }
  get '/external/assets/ncce.css', to: 'asset_endpoint#css_endpoint', as: :css_endpoint

  get '/gender-balance', to: 'pages#page', as: :gender_balance, defaults: { page_slug: 'gender-balance' }
  get '/get-involved', to: 'pages#page', as: :get_involved, defaults: { page_slug: 'get-involved' }
  get '/secondary-early-careers', to: 'pages#page', as: :secondary_early_careers, defaults: { page_slug: 'secondary-early-careers' }
  get '/primary-early-careers', to: 'pages#page', as: :primary_early_careers, defaults: { page_slug: 'primary-early-careers' }
  get '/powerupthedigitalgeneration', to: redirect('/supporting-partners')
  get '/hero-demo', to: 'pages#page', as: :hero_demo, defaults: { page_slug: 'hero-demo' }
  get '/pedagogy', to: 'pages#page', as: :pedagogy, defaults: { page_slug: 'pedagogy' }
  get '/impact-and-evaluation', to: 'pages#page', as: :impact, defaults: { page_slug: 'impact-and-evaluation' }
  get '/a-level-computer-science', to: 'pages#page', as: :a_level_computer_science,
                                   defaults: { page_slug: 'a-level-computer-science' }
  get '/gcse-revision', to: 'pages#page', as: 'gcse-revision',
                        defaults: { page_slug: 'gcse-revision' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/maintenance', to: 'pages#page', as: :maintenance, defaults: { page_slug: 'maintenance' }
  get '/contributing-partners', to: 'pages#page', as: :contributing_partners,
                                defaults: { page_slug: 'contributing-partners' }
  get '/primary-certificate', to: 'pages#static_programme_page', as: :primary,
                              defaults: { page_slug: 'primary-certificate' }
  get '/primary-teachers', to: 'landing_pages#primary_teachers', as: :primary_teachers,
                           defaults: { slug: 'primary-certificate' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/secondary-certificate',
      to: 'pages#static_programme_page',
      as: :secondary,
      defaults: { page_slug: 'secondary-certificate' },
      constraints: lambda { |_request|
                     Programme.secondary_certificate.enrollable?
                   }
  get '/secondary-senior-leaders', to: 'pages#page', as: :secondary_senior_leaders,
                                   defaults: { page_slug: 'secondary-senior-leaders' }
  get '/primary-senior-leaders', to: 'pages#page', as: :primary_senior_leaders,
                                 defaults: { page_slug: 'primary-senior-leaders' }
  get '/secondary-teachers', to: 'landing_pages#secondary_teachers', as: :secondary_teachers
  get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/supporting-partners', to: 'pages#page', as: :supporting_partners, defaults: { page_slug: 'supporting-partners' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/welcome', to: 'welcome#show', as: :welcome

  # CMS ROUTES
  get '/home-teaching-resources' => redirect('/home-teaching')
  get '/home-teaching/:page_slug' => redirect('/home-teaching')
  get '/:parent_slug/:page_slug/refresh', to: 'cms#clear_page_cache'
  get '/:page_slug/refresh', to: 'cms#clear_page_cache'

  constraints ->(req) { req.format == :html } do
    get '/:parent_slug/:page_slug', to: 'cms#cms_page'
    get '/:page_slug', to: 'cms#cms_page'
  end
end
