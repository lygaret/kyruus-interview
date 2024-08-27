Rails.application.routes.draw do
  resources :check_ins, only: [:new, :create, :show, :update] do
    resources :assessments, only: [:show, :update]
  end

  root to: "check_ins#new"
end
