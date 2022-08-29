# frozen_string_literal: true

module OutputService
  class CurrentTempService
    def initialize(weather)
      @weather = weather
    end

    def result
      Time.zone = 'Moscow'
      {
        time: @weather.local_time.in_time_zone('Moscow').strftime('%Y-%m-%d %H:%M:%S %z'),
        temperature: @weather.temperature
      }
    end
  end
end
