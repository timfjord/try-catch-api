Rails.application.routes.draw do
  resources :users, only: [] do
    post :sign_in, on: :collection
  end

  resources :teams do
    resources :players, except: :show, shallow: true
  end
end
