Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :schedules, only: [:index, :show]

      get '/users/:id/schedule', to: 'users#show'
      delete '/schedules/:schedule_id/shows/:id', to: 'schedules#destroy'
      post '/schedules/:schedule_id/shows', to: 'shows#create'
    end
  end
end
