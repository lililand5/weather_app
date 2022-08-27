# frozen_string_literal: true

Rails.application.routes.draw do
  mount Weathers::WeathersApi => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # get '/health', to: 'main#health', as: 'health'
end
