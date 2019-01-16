Rails.application.routes.draw do
  get '/auth/callback', to: 'auth#callback', as: 'callback'

  root to: 'home#index'

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
end
