# frozen_string_literal: true

class TempByTimeService
  def initialize(unix_time)
    @unix_time = unix_time.to_i
  end

  def result
    return { message: '400: Blank time', status: 400 } if @unix_time.nil?
    return { message: '404: Not Found', status: 404 } if close_weather.nil?

    format_weather(close_weather)
  end

  private

  def close_weather
    weathers = weathers_cache
    weathers.map! do |weather|
      hash = weather.attributes.symbolize_keys
      hash[:difference] = (hash[:epoch_time] - @unix_time).abs
      hash
    end

    weathers.min { |a, b| a[:difference] <=> b[:difference] }
  end

  def weathers_cache
    Rails.cache.fetch(@unix_time.to_s, expires_in: 10.minutes) do
      Weather.where(epoch_time: ((@unix_time - 3600)..(@unix_time + 3600))).to_a
    end
  end

  def format_weather(weather)
    {
      time: weather[:local_time],
      temperature: weather[:temperature]
    }
  end
end
