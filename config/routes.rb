Rails.application.routes.draw do
  resources :users, only: [] do
    post :sign_in, on: :collection
  end

  resources :teams do
    get :build, on: :collection

    resources :players, except: :show, shallow: true
  end

  get 'players/build' => 'players#build', as: 'build_players'
end
