Rails.application.routes.draw do
  root to: 'rooms#index'

  resources :rooms, only: [:create, :index, :show], param: :token
  resources :rooms do
    member do
      patch :public
    end
  end

  mount ActionCable.server => '/cable'
end
