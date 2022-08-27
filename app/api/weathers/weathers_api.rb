require 'grape-swagger'

module Weathers
  class WeathersApi < Grape::API
    format :json

    resource :weather do
      desc 'Return current weather'
      get :current do
        {current_temp: "00"}
      end

      # desc 'Return historical data about weather'
      # get :historical do
      #   ["123"]
      # end
    end

    desc 'health'
    get '/health' do
      {status: 'OK'}
    end

    # add_swagger_documentation

    add_swagger_documentation :add_version => true,
                            :base_path => '/api'
  end
end
