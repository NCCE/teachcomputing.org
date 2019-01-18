Rails.application.routes.draw do
  get '/auth/callback', to: 'auth#callback', as: 'callback'

  root to: 'pages#home', action: :home

  get 'dashboard', action: :show, controller: 'dashboard'
  resources :courses, path: '/dashboard/courses', only: [:index]

  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/news', to: 'pages#page', as: :news, defaults: { page_slug: 'news' }
  get '/contact', to: 'pages#page', as: :contact, defaults: { page_slug: 'contact' }
  get '/login', to: 'pages#page', as: :login, defaults: { page_slug: 'login' }
  get '/logout', to: 'auth#logout', as: :logout
  get '/signup-stem', to: 'pages#page', as: :signup_stem, defaults: { page_slug: 'signup-stem' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/offer', to: 'pages#page', as: :offer, defaults: { page_slug: 'offer' }
  get '/certification', to: 'pages#page', as: :certification, defaults: { page_slug: 'certification' }
  get '/404', to: 'pages#exception', defaults: { status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }
end
