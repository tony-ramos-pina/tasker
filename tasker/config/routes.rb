Rails.application.routes.draw do
  devise_for :users

  resources :tasks do
    member do
      get :setAsDone
      patch :setAsDone
      get :setAsNotDone
      patch :setAsNotDone
      get :searchByTag    
    end
    collection do   
      get :search
    end
  end

  get '/user' => "tasks#index", :as => :user_root
  
  root to: "main#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
