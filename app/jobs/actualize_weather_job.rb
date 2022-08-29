# frozen_string_literal: true

class ActualizeWeatherJob
  include Sidekiq::Job

  def perform
    service = ActualizeWeatherService.new
    service.check_weather
  end
end
