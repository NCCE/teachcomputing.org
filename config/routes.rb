Rails.application.routes.draw do
  root to: 'pages#home', action: :home

  resources :achievements, only: %i[create destroy]

  namespace 'admin' do
    delete '/cache', to: 'cache#destroy'
    resources :imports, only: %i[index new create]
    resources :activities, only: %i[index]
    get '/users', to: 'users#show'
    resources :users, only: %i[] do
      resources :achievements, only: %i[create] do
        post 'complete', action: :complete
      end
    end
    resources :user_programme_enrolments, only: %i[show] do
      post '/complete', action: :complete
      post '/enrolled', action: :enrolled
      post '/flag', action: :flag
    end
  end

  resources :assessment_attempts, only: %i[create]

  namespace 'certificates', path: 'certificate', as: '' do
    resource 'primary_certificate', controller: 'primary_certificate', path: 'primary-certificate', only: %i[show] do
      get '/complete', action: :complete, as: :complete
      get '/pending', action: :pending, as: :pending
      get '/questionnaire/:id', to: '/diagnostics/primary_certificate#show', as: :diagnostic
      put '/questionnaire/:id', to: '/diagnostics/primary_certificate#update', as: :update_diagnostic
      get '/view-certificate', action: :show, controller: 'certificate', as: :certificate, defaults: { slug: 'primary-certificate' }
    end
  end

  get '/certificate/:slug', action: :show, controller: 'programmes', as: :programme
  get '/certificate/:slug/complete', action: :complete, controller: 'programmes', as: :programme_complete
  get '/certificate/:slug/pending', action: :pending, controller: 'programmes', as: :programme_pending

  get '/certificate/:slug/view-certificate', action: :show, controller: 'certificates/certificate', as: :programme_certificate

  post '/certificate/:slug/enrol', action: :create, controller: 'user_programme_enrolments', as: :user_programme_enrolment
  get '/certificate/cs-accelerator/diagnostic/:id', to: 'diagnostics/cs_accelerator#show', as: :cs_accelerator_diagnostic

  namespace 'class_marker' do
    post '/webhook', to: 'webhooks#assessment', as: 'assessment_webhook'
  end

  get '/courses', action: :index, controller: 'courses', as: 'courses'
  get '/courses/:id(/:name)', action: :show, controller: 'courses', as: 'course'

  get '/curriculum', to: 'curriculum/key_stages#index', as: :curriculum_key_stages
  get '/curriculum/:key_stage_slug', to: 'curriculum/key_stages#show', as: :curriculum_key_stage_units
  get '/curriculum/:key_stage_slug/:unit_slug', to: 'curriculum/units#show', as: :curriculum_key_stage_unit
  get '/curriculum/:key_stage_slug/:unit_slug/:lesson_slug', to: 'curriculum/lessons#show', as: :curriculum_key_stage_unit_lesson
  get '/curriculum/rating/units/:polarity/:id/:user_id', to: 'curriculum/units#rate', as: :create_curriculum_unit_rating
  post '/curriculum/rating/comment', to: 'curriculum/units#comment', as: :update_curriculum_unit_rating
  get '/curriculum/rating/lessons/:polarity/:id/:user_id', to: 'curriculum/lessons#rate', as: :create_curriculum_lesson_rating
  post '/curriculum/rating/comment', to: 'curriculum/lessons#comment', as: :update_curriculum_lesson_rating

  get 'dashboard', action: :show, controller: 'dashboard'

  get '/early-career-teachers', to: 'cms#cms_page', as: :early_career_teachers, defaults: { page_slug: 'early-career-teachers' }

  get '/futurelearn/lti/:fl_id', to: 'future_learn/lti#show', as: 'futurelearn_lti'
  patch '/users/:id/teacher-reference-number', action: :teacher_reference_number, controller: 'user', as: :user_teacher_reference_number

  get '/404', to: 'pages#exception', defaults: { format: 'html', status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/accelerator', to: redirect('/cs-accelerator')
  get '/accessibility-statement', to: 'pages#page', as: :accessibility_statement, defaults: { page_slug: 'accessibility-statement' }
  get '/auth/stem', to: redirect('/login')
  get '/auth/callback', to: 'auth#callback', as: 'callback'
  get '/bursary', to: 'cms#cms_page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/bursary/refresh', to: 'cms#clear_page_cache', defaults: { page_slug: 'bursary' }
  get '/careers-week', to: 'pages#page', as: :careers_week, defaults: { page_slug: 'careers-week' }
  get '/cms/:page_slug', action: :cms_page, controller: :cms, as: :cms_page, defaults: { page_slug: 'hubs' }
  get '/cms/:page_slug/refresh', action: :clear_page_cache, controller: :cms, as: :clear_page_cache, defaults: { page_slug: 'hubs' }
  get '/competition-terms-and-conditions', to: 'pages#page', as: :competition_terms_and_conditions, defaults: { page_slug: 'competition-terms-and-conditions' }
  get '/cs-accelerator', to: 'pages#static_programme_page', as: :cs_accelerator, defaults: { page_slug: 'cs-accelerator' }
  get '/external/assets/ncce.css', to: 'asset_endpoint#css_endpoint', as: :css_endpoint
  get '/faq/courses/', to: 'cms#cms_page', as: :faq_courses, defaults: { page_slug: 'faq-courses' }
  get '/faq/courses/refresh', to: 'cms#clear_page_cache', defaults: { page_slug: 'faq-courses' }
  get '/fl-trailers', to: 'pages#page', as: :trailers, defaults: { page_slug: 'fl-trailers' }
  get '/gender-balance', to: 'pages#page', as: :gender_balance, defaults: { page_slug: 'gender-balance' }
  get '/get-involved', to: 'pages#page', as: :get_involved, defaults: { page_slug: 'get-involved' }
  get '/home-teaching', to: 'pages#page', as: :home_teaching, defaults: { page_slug: 'home-teaching' }
  get '/hero-demo', to: 'pages#page', as: :hero_demo, defaults: { page_slug: 'hero-demo' }
  get '/home-teaching/:page_slug', to: 'cms#cms_page', as: :cms_home_teaching_page, defaults: { page_slug: 'key-stage-1' }
  get '/home-teaching/:page_slug/refresh', to: 'cms#clear_page_cache', as: :clear_home_teaching_page_cache, defaults: { page_slug: 'key-stage-1' }
  get '/hubs', to: 'cms#cms_page', as: :hubs, defaults: { page_slug: 'hubs' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/maintenance', to: 'pages#page', as: :maintenance, defaults: { page_slug: 'maintenance' }
  get '/pedagogy', to: 'cms#cms_page', as: :pedagogy, defaults: { page_slug: 'pedagogy' }
  get '/pedagogy/refresh', to: 'cms#clear_page_cache', defaults: { page_slug: 'pedagogy' }
  get '/primary-certificate', to: 'pages#static_programme_page', as: :primary, defaults: { page_slug: 'primary-certificate' },
                              constraints: ->(_request) { Programme.primary_certificate.enrollable? }
  get '/primary-teachers', to: 'landing_pages#primary_teachers', as: :primary_teachers, defaults: { slug: 'primary-certificate' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/secondary-certificate', to: 'pages#static_programme_page', as: :secondary, defaults: { page_slug: 'secondary-certificate' },
                                constraints: ->(_request) { Programme.secondary_certificate.enrollable? }
  get '/secondary-senior-leaders', to: 'pages#page', as: :secondary_senior_leaders, defaults: { page_slug: 'secondary-senior-leaders' }
  get '/secondary-teachers', to: 'landing_pages#secondary_teachers', as: :secondary_teachers, defaults: { slug: 'cs-accelerator' }
  get '/support-for-ite-providers', to: 'cms#cms_page', as: :support_for_ite_providers, defaults: { page_slug: 'support-for-ite-providers' }
  get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/take-the-next-step-in-your-career', to: 'cms#cms_page', as: :take_the_next_step_in_your_career, defaults: { page_slug: 'take-the-next-step-in-your-career' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/trailer-demo', to: 'pages#page', defaults: { page_slug: 'trailer-demo' }
  get '/welcome', to: 'welcome#show', as: :welcome

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'admin/sidekiq'
end
