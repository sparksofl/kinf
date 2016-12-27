Rails.application.routes.draw do
  resources :journals
  resources :workers
  resources :genres
  resources :authors
  resources :books
  resources :users
  get 'ban_user' => 'users#ban'
  get 'update_salary' => 'workers#edit_salary'
  post 'update_salary' => 'workers#update_salary'
  get 'worker_error' => 'workers#ora_error'
  get 'add_to_salary' => 'workers#edit_add_to_salary'
  post 'add_to_salary' => 'workers#add_to_salary'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
