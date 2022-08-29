# frozen_string_literal: true

module OutputService
  class CurrentTempService
    def initialize(weather)
      @weather = weather
    end

    def result
      Time.zone = 'Moscow'
      {
        time: Time.zone.parse(@weather.local_time.to_s).strftime('%Y-%m-%d %H:%M:%S %z'),
        temperature: @weather.temperature
      }
    end
  end
end
