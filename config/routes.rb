Rails.application.routes.draw do
  resources :check_ins, only: [:new, :create, :show, :update] do
    resource :phq_assessment, only: [:new]
  end

  root to: "check_ins#new"
end
