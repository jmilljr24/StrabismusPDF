Rails.application.routes.draw do
  devise_for :users
  resources :blog_posts do
    collection do
      get :filter_kit
    end
  end
  resources :user_pdfs
  # resources :parse
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check
  # post "parse" => "parse#parse_file", :as => :parse_file
  # get "parse/show" => "parse#show", :as => :parse_show
  # get "downloads" => "parse#download", :as => :download
  # get "preview" => "parse#preview", :as => :preview
  get "information" => "application#information"
  get "files/info" => "application#files_info", :as => :files_info
  get "user_pdfs/color/:id" => "user_pdfs#colorize_pdf", :as => :colorize_pdf
  get "user_pdfs/recolor/:id" => "user_pdfs#recolorize", :as => :recolorize

  # Defines the root path route ("/")
  # root 'user_pdfs#new'
  root "user_pdfs#index"
end
