Rails.application.routes.draw do
  root 'static_pages#index'
  resources :tasks
  get '/tasks/delete', to: 'tasks#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
