Rails.application.routes.draw do
  root to: 'home#index'
  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/news', to: 'pages#page', as: :news, defaults: { page_slug: 'news' }
  get '/contact', to: 'pages#page', as: :contact, defaults: { page_slug: 'contact' }
  get '/login', to: 'pages#page', as: :login, defaults: { page_slug: 'login' }
  get '/dashboard', to: 'pages#page', as: :dashboard, defaults: { page_slug: 'dashboard' }
  get '/dashboard/courses', to: 'courses#courses', as: :courses, defaults: { page_slug: 'dashboard/courses' }
  get '/dashboard/courses/:id', to: 'courses#course', as: :course, defaults: {}
end
