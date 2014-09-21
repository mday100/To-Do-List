Rails.application.routes.draw do

  resources :lists do
    resources :tasks
  #   resources :tasks do
  #     get :complete
  #   end
  end

  match 'lists/:list_id/tasks/:id/complete' => 'tasks#complete', :as => :complete_task, via: [:get, :post]

  root to: 'lists#index'

end
