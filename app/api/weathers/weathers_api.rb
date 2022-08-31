# frozen_string_literal: true

module Weathers
  class WeathersApi < Grape::API
    format :json

    namespace 'weather' do
      get 'current' do
        Weather.current_weather
      end

      namespace 'historical' do
        get '/' do
          Weather.last_weathers
        end

        get '/max' do
          Weather.max
        end

        get '/min' do
          Weather.min
        end

        get '/avg' do
          Weather.avg
        end
      end

      get 'by_time' do
        Weather.by_time(params[:unix_time])
      end
    end

    get '/health' do
      { status: 'OK' }
    end
  end
end



# def current
#   render json: Weather.current_weather
# end

# def historical
#   render json: Weather.last_weathers
# end

# def historical_max
#   render json: Weather.max
# end

# def historical_min
#   render json: Weather.min
# end

# def historical_avg
#   render json: Weather.avg
# end

# def by_time
#   render json: Weather.by_time(params[:unix_time])
# end
