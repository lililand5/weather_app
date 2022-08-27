# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get '/health', to: 'main#health', as: 'health'

  resources :weather do
    collection do
      get '/current', to: 'weathers#current', as: 'current'
      get '/historical', to: 'weathers#historical', as: 'historical'
      get '/historical/max', to: 'weathers#historical_max', as: 'historical_max'
      get '/historical/min', to: 'weathers#historical_min', as: 'historical_min'
      get '/historical/avg', to: 'weathers#historical_avg', as: 'historical_avg'
      get '/by_time', to: 'weathers#by_time', as: 'by_time'
    end
  end
end
