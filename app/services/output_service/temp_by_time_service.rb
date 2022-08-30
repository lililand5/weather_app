# frozen_string_literal: true

module OutputService
  class TempByTimeService
    def initialize(date_time)
      @date_time = date_time
    end

    def result
      return { message: '404: Not Found', status: 404 } if @date_time > Weather.last.epoch_time
      return format_weather(Weather.first) if @date_time < Weather.first.epoch_time

      close_weather
    end

    private

    def close_weather
      weathers = Weather.where(epoch_time: ((@date_time - 3600)..(@date_time + 3600))).to_a
      range = weathers.map { |weather| (weather.epoch_time - @date_time).abs }
      range.first < range.last ? format_weather(weathers.first) : format_weather(weathers.last)
    end

    def format_weather(weather)
      {
        time: weather.local_time,
        temperature: weather.temperature
      }
    end
  end
end
