# frozen_string_literal: true

class Weather < ApplicationRecord
  def self.current_weather
    weather = cache_weather
    prepared_data(weather)
  end

  def self.last_weathers
    weathers = cache_weathers
    prepared_list_data(weathers)
  end

  def self.max
    weathers = cache_weathers
    prepared_data(calculate_max(weathers))
  end

  def self.min
    weathers = cache_weathers
    prepared_data(calculate_min(weathers))
  end

  def self.avg
    weathers = cache_weathers
    calculate_avg(weathers)
  end

  def self.cache_weather
    Rails.cache.fetch('last', expires_in: 1.minute) do
      last
    end
  end

  def self.cache_weathers
    Rails.cache.fetch('last', expires_in: 1.minute) do
      last(24)
    end
  end

  def self.prepared_data(weather)
    {
      time: weather.local_time,
      temperature: weather.temperature
    }
  end

  def self.prepared_list_data(weathers)
    weathers.map do |weather|
      {
        time: weather.local_time,
        temperature: weather.temperature
      }
    end
  end

  def self.calculate_max(weathers)
    weathers.select { |w| w[:temperature].to_i }.max
  end

  def self.calculate_min(weathers)
    weathers.select { |w| w[:temperature].to_i }.min
  end

  def self.calculate_avg(weathers)
    temperatures = weathers.pluck(:temperature)
    (temperatures.sum / temperatures.size).round(1)
  end
end
