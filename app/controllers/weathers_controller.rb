# frozen_string_literal: true

class WeathersController < ApplicationController
  def current
    service = CurrentTempService.new
    service.set_current_temp

    render json: service.result    # render json: body.first["LocalObservationDateTim"]
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
