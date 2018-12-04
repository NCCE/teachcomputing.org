Rails.application.routes.draw do
  root to: 'home#index'

  scope '/dashboard' do
    root to: 'dashboard#show'
    resources :courses, only: %i[index, show]
  end

  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/news', to: 'pages#page', as: :news, defaults: { page_slug: 'news' }
  get '/contact', to: 'pages#page', as: :contact, defaults: { page_slug: 'contact' }
  get '/login', to: 'pages#page', as: :login, defaults: { page_slug: 'login' }
end
