# frozen_string_literal: true

class WeathersController < ApplicationController
  def current
    render json: Weather.last, serializer: CurrentTempSerializer
  end

  def historical
    render json: '123'
  end

  def historical_max
    render json: '123'
  end

  def historical_min
    render json: '123'
  end

  def historical_avg
    render json: '123'
  end

  def by_time
    render json: '123'
  end
end
