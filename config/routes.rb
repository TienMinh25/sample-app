Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "application#hello"
  # Defines the root path route ("/")
  # root "articles#index"
end
