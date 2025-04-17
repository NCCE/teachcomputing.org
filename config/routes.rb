Rails.application.routes.draw do
  Healthcheck.routes(self)
  root to: "cms#home", action: :home

  resources :achievements, only: %i[create destroy update] do
    collection do
      post :submit
    end
  end
  namespace :admin do
    root to: "pathways#index"
    resources :badges
    resources :activities
    resources :pathways
    resources :pathway_activities
    resources :hubs
    resources :hub_regions
    resources :support_audits, only: %i[index show update edit]

    resources :users, only: %i[index create show edit perform_sync perform_reset update] do
      get "/perform_sync/:user_id", to: "users#perform_sync", as: :perform_sync
      get "/perform_reset/:user_id", to: "users#perform_reset_tests", as: :perform_reset
      get "/generate_assessment_attempt", to: "users#generate_assessment_attempt", as: :generate_assessment_attempt unless Rails.env.production?
      post "/process_assessment_attempt", to: "users#process_assessment_attempt", as: :process_assessment_attempt unless Rails.env.production?
    end
    resources :user_programme_enrolments, only: %i[index show edit update] do
      member do
        get :generate_certificate
      end
    end
    achievement_actions = Rails.env.production? ? %i[index show] : %i[index show create new destroy update]
    resources :achievements, only: achievement_actions do
      member do
        post :reject_evidence
      end
    end
    resources :assessment_attempts, only: %i[index show]
    resources :assessment_attempt_transitions
    resources :reports, only: [:index] do
      collection do
        get :by_programme
        post :report_results
      end
    end
    resources :sent_emails, only: %i[index show]
  end

  namespace :api do
    delete "/cache", to: "cache#destroy"
    get "/users", to: "users#show"
    delete "/users/forget", to: "users#forget"
    resources :users, only: %i[] do
      resources :achievements, only: %i[create] do
        post "complete", action: :complete
      end
    end
    resources :activities, only: %i[index]
    resources :user_programme_enrolments, only: %i[show] do
      resources :activities, only: %i[index]
      post "/complete", action: :complete
      post "/enrolled", action: :enrolled
      post "/flag", action: :flag
    end
  end

  require "sidekiq/web"
  mount Sidekiq::Web, at: "admin/sidekiq"

  resources :assessment_attempts, only: %i[create]

  namespace "certificates", path: "certificate", as: "" do
    resource "primary_certificate", controller: "primary_certificate", path: "primary-certificate", only: %i[show] do
      get "/complete", to: redirect("/certificate/primary-certificate")
      get "/pending", to: redirect("/certificate/primary-certificate")
      get "/view-certificate", action: :show, controller: "certificate", as: :certificate,
        defaults: {slug: "primary-certificate"}
      post "/enrol", action: :create, controller: "/user_programme_enrolments", as: :enrol
      put "/pathway", action: :update, controller: "primary_certificate/user_programme_pathway", as: :update_user_pathway
    end

    resource "secondary_certificate", controller: "secondary_certificate", path: "secondary-certificate",
      only: %i[show] do
      get "/complete", action: :complete, as: :complete
      get "/pending", action: :pending, as: :pending
      get "/view-certificate", action: :show, controller: "certificate", as: :certificate,
        defaults: {slug: "secondary-certificate"}
      post "/enrol", action: :create, controller: "/user_programme_enrolments", as: :enrol
      put "/pathway", action: :update, controller: "secondary_certificate/user_programme_pathway", as: :update_user_pathway
    end

    resource "cs_accelerator", controller: "cs_accelerator", path: "subject-knowledge", only: %i[show],
      as: :cs_accelerator_certificate do
      get "/complete", action: :complete, as: :complete
      get "/pending", action: :pending, as: :pending
      get "/questionnaire/:id", to: "/diagnostics/cs_accelerator#show", as: :diagnostic
      put "/questionnaire/:id", to: "/diagnostics/cs_accelerator#update", as: :update_diagnostic
      get "/class_marker_diagnostic/:id", to: "/diagnostics/class_marker/cs_accelerator#show",
        as: :class_marker_diagnostic
      get "/view-certificate", action: :show, controller: "certificate", as: :certificate,
        defaults: {slug: "subject-knowledge"}
      post "/enrol", action: :create, controller: "/user_programme_enrolments", as: :enrol
      get "/unenrol/:id", action: :destroy, controller: "/user_programme_enrolments", as: :unenrol
      put "/pathway", action: :update, controller: "cs_accelerator/user_programme_pathway", as: :update_user_pathway
    end

    resource "i_belong", controller: "i_belong", path: "i-belong", only: :show, as: :i_belong do
      get "/complete", action: :complete, as: :complete
      get "/pending", action: :pending, as: :pending
      get "/view-certificate", action: :show, controller: "certificate", as: :certificate,
        defaults: {slug: "i-belong"}
      post "/enrol", action: :create, controller: "/user_programme_enrolments", as: :enrol
    end

    resource "a_level", controller: "a_level", path: "a-level-certificate", only: :show, as: :a_level do
      get "/complete", action: :complete, as: :complete
      get "/view-certificate", action: :show, controller: "certificate", as: :certificate,
        defaults: {slug: "a-level-certificate"}
      post "/enrol", action: :create, controller: "/user_programme_enrolments", as: :enrol
    end

    namespace "cs_accelerator" do
      resource "auto_enrolment", only: [] do
        get "/unenroll", action: :destroy
      end
    end

    namespace "i_belong" do
      resource "auto_enrolment", only: [] do
        get "/unenroll", action: :destroy
      end
    end

    resources :pathways, param: :slug, only: %i[show]
  end

  namespace "class_marker" do
    post "/webhook", to: "webhooks#assessment", as: "assessment_webhook"
  end

  resources :user_programme_enrolments, only: %i[update] do
    collection do
      delete :destroy_message_flags_primary_pathway_migrated
    end
  end

  resource :feedback, only: %i[create]
  resources :downloads, only: %i[create]

  # April 2025 Redirects

  get "/computing-clusters", to: redirect("/")
  get "/hubs", to: redirect("/")
  get "/bursary", to: redirect("/")
  get "/funding", to: redirect("/")
  get "/courses/hubs/:hub_id", to: redirect("/courses"), as: "hub"

  get "/courses", action: :index, controller: "courses", as: "courses"
  get "/courses/filter", action: :filter, controller: "courses", as: "course_filter"
  get "/courses/:id(/:name)", action: :show, controller: "courses", as: "course"

  # get "/curriculum", to: "curriculum/key_stages#index", as: :curriculum_key_stages
  get "/curriculum", to: "pages#web_page_resource", as: :curriculum_key_stages, defaults: {page_slug: "curriculum"}
  get "/curriculum/files/:slug", to: "curriculum/file_redirect#redirect_to_file", as: :curriculum_file_redirect
  get "/curriculum/:key_stage_slug", to: "curriculum/key_stages#show", as: :curriculum_key_stage_units
  get "/curriculum/:key_stage_slug/:unit_slug", to: "curriculum/units#show", as: :curriculum_key_stage_unit
  get "/curriculum/:key_stage_slug/:unit_slug/:lesson_slug", to: "curriculum/lessons#show",
    as: :curriculum_key_stage_unit_lesson
  post "/curriculum/rating/units/:polarity/:id/:user_id", to: "curriculum/units#rate", as: :create_curriculum_unit_rating
  post "/curriculum/rating/comment", to: "curriculum/units#comment", as: :update_curriculum_unit_rating
  post "/curriculum/rating/choices", to: "curriculum/units#choices", as: :update_curriculum_unit_rating_choices
  post "/curriculum/rating/lessons/:polarity/:id/:user_id", to: "curriculum/lessons#rate", as: :create_curriculum_lesson_rating
  post "/curriculum/rating/comment", to: "curriculum/lessons#comment", as: :update_curriculum_lesson_rating
  post "/curriculum/rating/choices", to: "curriculum/lessons#choices", as: :update_curriculum_lesson_rating_choices

  get "dashboard", action: :show, controller: "dashboard"

  namespace "dynamics" do
    post "/webhook", to: "webhooks#user", as: "user_webhook"
  end

  patch "/users/:id/teacher-reference-number", action: :teacher_reference_number, controller: "user",
    as: :user_teacher_reference_number

  get "/404", to: "pages#exception", defaults: {status: 404}
  get "/422", to: "pages#exception", defaults: {status: 422}
  get "/500", to: "pages#exception", defaults: {status: 500}
  get "/accelerator", to: redirect("/subject-knowledge")
  get "/accessibility-statement", to: "pages#page", as: :accessibility_statement,
    defaults: {page_slug: "accessibility-statement"}
  get "/auth/stem", to: redirect("/login")
  get "/auth/callback", to: "auth#callback", as: "callback"
  get "/careers-week", to: redirect("/careers-support")
  get "/careers", to: redirect("/careers-support")
  get "/careers-support", to: "pages#page", as: :careers_support, defaults: {page_slug: "careers-support"}
  get "/competition-terms-and-conditions", to: "pages#page", as: :competition_terms_and_conditions,
    defaults: {page_slug: "competition-terms-and-conditions"}
  get "/subject-knowledge", to: "pages#static_programme_page", as: :cs_accelerator,
    defaults: {page_slug: "subject-knowledge"}
  get "/a-level-certificate", to: "pages#static_programme_page", as: :about_a_level,
    defaults: {page_slug: "a-level-certificate"}
  get "/external/assets/ncce.css", to: "asset_endpoint#css_endpoint", as: :css_endpoint

  # get "/tech-careers-videos", to: "pages#page", as: :tech_careers_videos, defaults: {page_slug: "tech-careers-videos"}
  # get "/i-belong", to: "pages#i_belong", as: :about_i_belong, defaults: {page_slug: "i-belong"}

  get "/computing-teaching-schools-support", to: redirect("/gcse-cs-support")
  get "/isaac-computer-science", to: "pages#isaac_computer_science", as: :about_isaac_computer_science, defaults: {page_slug: "isaac-computer-science"}
  # get "/gender-balance", to: "pages#page", as: :gender_balance, defaults: {page_slug: "gender-balance"}
  # get "/secondary-question-banks", to: "pages#page", as: :secondary_question_banks, defaults: {page_slug: "secondary-question-banks"}
  get "/powerupthedigitalgeneration", to: redirect("/supporting-partners")
  get "/impact-and-evaluation", to: "pages#page", as: :impact, defaults: {page_slug: "impact-and-evaluation"}
  get "/a-level-computer-science", to: redirect("/isaac-computer-science")
  get "/gcse-revision", to: redirect("/isaac-computer-science")
  get "/login", to: "pages#login", as: :login
  get "/logout", to: "auth#logout", as: :logout
  get "/maintenance", to: "pages#page", as: :maintenance, defaults: {page_slug: "maintenance"}
  get "/contributing-partners", to: redirect("/get-involved")

  get "/primary-certificate/courses", action: :primary_courses, controller: "courses", as: :primary_courses

  # get "/primary-teachers", to: "pages#page", as: :primary_teachers,
  #  defaults: {page_slug: "primary-toolkit"}
  get "/secondary-certificate",
    to: "pages#static_programme_page",
    as: :secondary,
    defaults: {page_slug: "secondary-certificate"},
    constraints: lambda { |_request|
                   Programme.secondary_certificate.enrollable?
                 }
  # get "/secondary-senior-leaders", to: "pages#page", as: :secondary_senior_leaders,
  #  defaults: {page_slug: "secondary-senior-leaders"}
  # get "/primary-senior-leaders", to: "pages#page", as: :primary_senior_leaders,
  #  defaults: {page_slug: "primary-senior-leaders"}
  get "/secondary-teachers", to: "pages#page", as: :secondary_teachers,
    defaults: {page_slug: "secondary-toolkit"}
  get "/secondary-certification", to: "pages#secondary-certification", as: :secondary_certification
  get "/signup-confirmation", to: "pages#page", as: :signup_confirmation, defaults: {page_slug: "signup-confirmation"}
  get "/supporting-partners", to: redirect("/get-involved")
  # get "/terms-conditions", to: "pages#page", as: :terms_conditions, defaults: {page_slug: "terms-conditions"}

  resource :search, only: :show

  get "/certificate/cs-accelerator", to: redirect("/certificate/subject-knowledge")
  get "/cs-accelerator", to: redirect("/subject-knowledge")

  # CMS ROUTES
  get "/primary-enrichment", to: "cms#enrichment", defaults: {page_slug: "primary-enrichment"}, as: :primary_enrichment
  get "/primary-enrichment/refresh", to: "cms#enrichment_refresh", defaults: {page_slug: "primary-enrichment"}, as: :primary_enrichment_reload
  get "/secondary-enrichment", to: "cms#enrichment", defaults: {page_slug: "secondary-enrichment"}, as: :secondary_enrichment
  get "/secondary-enrichment/refresh", to: "cms#enrichment_refresh", defaults: {page_slug: "secondary-enrichment"}, as: :secondary_enrichment_reload

  get "/i-belong", to: "cms#web_page_resource", as: :about_i_belong, defaults: {page_slug: "i-belong"}
  get "/gender-balance", to: "cms#web_page_resource", as: :gender_balance, defaults: {page_slug: "gender-balance"}
  get "/secondary-senior-leaders", to: "cms#web_page_resource", as: :secondary_senior_leaders,
    defaults: {page_slug: "secondary-senior-leaders"}

  get "/home-teaching-resources" => redirect("/home-teaching")
  get "/home-teaching/:page_slug" => redirect("/home-teaching")
  get "/blog/:page_slug/refresh", to: "cms#clear_blog_cache"
  get "/:page_slug/refresh", to: "cms#web_page_refresh"

  get "/blog", to: "cms#blog", as: :cms_posts
  get "/blog/articles", to: redirect(path: "/blog")
  get "/blog/:page_slug", to: "cms#blog_resource", as: :cms_post
  get "/*page_slug", to: "cms#web_page_resource", as: :cms_page
end
