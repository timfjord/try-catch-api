Rails.application.routes.draw do
  resources :users, only: [] do
    post :sign_in, on: :collection
  end
end
