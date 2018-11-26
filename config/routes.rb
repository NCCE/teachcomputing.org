Rails.application.routes.draw do
  root to: 'home#index'
  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/register', to: 'pages#page', as: :register, defaults: { page_slug: 'register' }
  get '/dashboard', to: 'pages#page', as: :dashboard, defaults: { page_slug: 'dashboard' }
  get '/dashboard/courses', to: 'courses#courses', as: :courses, defaults: { page_slug: 'dashboard/courses' }
end
