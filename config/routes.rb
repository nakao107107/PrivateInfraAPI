Rails.application.routes.draw do
  post '/auth/login' => 'auth#login'
  get '/mentors/status' => 'mentors#status'
  get '/profile' => 'mentors#profile'
  resources :entors, only: [:index, :show, :update]
  resources :events, only: [:index, :show, :create, :update] do
    post '/post-to-slack' => 'events#post_to_slack'
    collection do
      resource :progress, only: [:show, :update]
    end
    resource :assign, only: [:create, :destroy]
  end
  resources :occupations, only: [:index]
  resources :industries, only: [:index]
  resources :appeals, only: [:index, :create]
end
