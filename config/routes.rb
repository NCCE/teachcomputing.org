Rails.application.routes.draw do
  get '/auth/callback', to: 'auth#callback', as: 'callback'

  root to: 'pages#home', action: :home

  get 'dashboard', action: :show, controller: 'dashboard'
  resources :courses, path: '/dashboard/courses', only: [:index]

  namespace :activities do
    resources :downloads, only: [:show]
  end

  resources :achievements, only: [:create]

  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/news', to: 'pages#page', as: :news, defaults: { page_slug: 'news' }
  get '/news/a-level', to: 'pages#page', as: :a_level, defaults: { page_slug: 'news/a-level' }
  get '/contact', to: 'pages#page', as: :contact, defaults: { page_slug: 'contact' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/edit-profile', to: 'auth#edit_profile', as: :edit_profile
  get '/signup-stem', to: 'pages#page', as: :signup_stem, defaults: { page_slug: 'signup-stem' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/offer', to: 'pages#page', as: :offer, defaults: { page_slug: 'offer' }
  get '/certification', to: 'pages#page', as: :certification, defaults: { page_slug: 'certification' }
  get '/accelerator', to: 'pages#page', as: :accelerator, defaults: { page_slug: 'accelerator' }
  get '/404', to: 'pages#exception', defaults: { status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
end
