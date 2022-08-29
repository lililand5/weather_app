# frozen_string_literal: true

class ActualizeWeatherService
  def check_weather
    service = TakeActualWeatherService.new
    service.check_last_weather
  end
end
