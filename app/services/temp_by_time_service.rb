# frozen_string_literal: true

class TempByTimeService
  def initialize(unix_time)
    @unix_time = unix_time
  end

  def result
    # return { message: '404: Not Found', status: 404 } if @unix_time > Weather.last.epoch_time
    # return format_weather(Weather.first) if @unix_time < Weather.first.epoch_time

    format_weather(close_weather)
  end

  private

  def close_weather
    weathers_cache =
      Rails.cache.fetch(@unix_time.to_s, expires_in: 10.minutes) do
        Weather.where(epoch_time: ((@unix_time - 3600)..(@unix_time + 3600))).to_a
      end

    weathers = weathers_cache.map do |weather|
      hash = weather.attributes.symbolize_keys
      hash[:difference] = (hash[:epoch_time] - @unix_time).abs
      hash
    end

    weathers.min { |a, b| a[:difference] <=> b[:difference] }
  end

  def format_weather(weather)
    {
      time: weather[:local_time],
      temperature: weather[:temperature]
    }
  end
end
