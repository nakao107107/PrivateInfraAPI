Rails.application.routes.draw do
  post '/auth/login' => 'auth#login'
  get '/mentors/status' => 'mentors#status'
  get '/profile' => 'mentors#profile'
  resources :entors, only: [:index, :show, :update]
  resources :events, only: [:index, :show, :create, :update] do
    collection do
      resource :progress, only: [:show, :update]
    end
  end
  resources :occupations, only: [:index]
  resources :industries, only: [:index]
  resources :appeals, only: [:index, :create]
end
