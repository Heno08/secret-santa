Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events, only: [:new, :create, :show] do
    resources :participants, only: [:new, :create] do
      collection do
        get :scramble
      end
    end
  end
end
