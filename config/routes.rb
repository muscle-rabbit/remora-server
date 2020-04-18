Rails.application.routes.draw do
  namespace :twitter do
    resources :timeline
    resources :users
  end

  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end