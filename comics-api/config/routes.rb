Rails.application.routes.draw do
  namespace :v1 do
    resources :comics do 
      member do
        get :like
      end
    end
  end
end
