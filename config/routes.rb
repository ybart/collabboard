Rails.application.routes.draw do
  root to: 'pages#home'
  resources :whiteboards, only: [:index, :show]
end
