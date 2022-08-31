# frozen_string_literal: true

class WeathersController < ApplicationController
  def current
    render json: Weather.current_weather
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
    render json: 'Bad request', status: '400' and return if params[:date_time].blank?

    servise = TempByTimeService.new(params[:date_time].to_i).result
    render json: servise, status: servise[:status]
  end
end
