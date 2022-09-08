# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  mount Weathers::WeathersApi => '/'

  # get '/my_page', to: 'pages#index'
  resources :pages
end
