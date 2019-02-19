Rails.application.routes.draw do
  root to: 'pages#home', action: :home

  namespace :achiever do
   delete '/cache', to: 'cache#destroy'
  end

  resources :achievements, only: [:create, :destroy]

  namespace :activities do
    resources :downloads, only: [:show]
  end

  get '/auth/callback', to: 'auth#callback', as: 'callback'

  resources :courses, path: '/dashboard/courses', only: [:index]

  get 'dashboard', action: :show, controller: 'dashboard'

  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/accelerator', to: 'pages#page', as: :accelerator, defaults: { page_slug: 'accelerator' }
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/certification', to: 'pages#page', as: :certification, defaults: { page_slug: 'certification' }
  get '/contact', to: 'pages#page', as: :contact, defaults: { page_slug: 'contact' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/news', to: 'pages#page', as: :news, defaults: { page_slug: 'news' }
  get '/news/a-level', to: 'pages#page', as: :a_level, defaults: { page_slug: 'news/a-level' }
  get '/offer', to: 'pages#page', as: :offer, defaults: { page_slug: 'offer' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/signup-stem', to: 'pages#page', as: :signup_stem, defaults: { page_slug: 'signup-stem' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/hub', to: 'pages#page', as: :hub, defaults: { page_slug: 'hub' }
  get '/404', to: 'pages#exception', defaults: { format: 'html', status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
end
