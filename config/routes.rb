Rails.application.routes.draw do
  resources :books, only: [:index, :create, :show, :destroy]
  resources :users, only: [:new, :create, :show, :edit] , path_names: { new: "sign_up"} #path_namesでurlをsign_up
  resource :session, path_names: { new: "sign_in"}
  resources :passwords, param: :token
  root to: "home#top"
  get "home/about", as:'about'#名前付きにすることでabout_pathを指定できるようにした。これがないとa hrefで/home/about等はよくても/userが来るとルーティングエラーになっていた
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
