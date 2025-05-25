Rails.application.routes.draw do
  root to: "pages#home"

  resources :whiteboards, only: [ :index, :show ] do
    resources :post_its, only: [ :create, :update, :destroy ]
  end
end
