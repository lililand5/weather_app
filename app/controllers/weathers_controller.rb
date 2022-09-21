# frozen_string_literal: true

class WeathersController < ApplicationController
  def current
    render json: Weather.current_weather
    #for rebase
  end

  def historical
    render json: Weather.last_weathers
  end

  def historical_max
    render json: Weather.max
  end

  def historical_min
    render json: Weather.min
  end

  def historical_avg
    render json: Weather.avg
  end

  def by_time
    render json: Weather.by_time(params[:unix_time])
  end
end
