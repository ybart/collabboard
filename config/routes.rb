Rails.application.routes.draw do
  default_url_options protocol: :https

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  # Pages
  root to: "pages#home"
  get "/pricing", to: "pages#pricing", as: :pricing

  # Whiteboards
  resources :whiteboards, only: [ :index, :show ] do
    resources :post_its, only: [ :create, :update, :destroy ]
  end
end
