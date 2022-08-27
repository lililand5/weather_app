Rails.application.routes.draw do
  root 'main#index'

  get '/health', to: 'main#health', as: 'health'
end
