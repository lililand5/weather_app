# frozen_string_literal: true

class Weather < ApplicationRecord
  def self.current_weather
    request = 'SELECT * FROM weathers ORDER BY id DESC LIMIT 1'
    result =
      Rails.cache.fetch('current', expires_in: 1.minute) do
        last
      end
    prepared_data(result)
  end

  def self.last_weathers
    request = 'SELECT * FROM weathers ORDER BY id DESC LIMIT 24'
    result =
      Rails.cache.fetch('last24', expires_in: 1.minute) do
        ActiveRecord::Base.connection.exec_query(request)[0]
      end
    prepared_data(result)
  end

  def self.max
    request = 'SELECT * FROM (SELECT * FROM weathers ORDER BY id DESC LIMIT 24) AS t1 ORDER BY temperature DESC LIMIT 1'
    result =
      Rails.cache.fetch('max', expires_in: 1.minute) do
        ActiveRecord::Base.connection.exec_query(request)[0]
      end
    prepared_data(result)
  end

  def self.min
    request = 'SELECT * FROM (SELECT * FROM weathers ORDER BY id DESC LIMIT 24) AS t1 ORDER BY temperature ASC LIMIT 1'
    result =
      Rails.cache.fetch('min', expires_in: 1.minute) do
        ActiveRecord::Base.connection.exec_query(request)[0]
      end
    prepared_data(result)
  end

  def self.avg
    request = 'SELECT AVG(temperature) AS temperature FROM (SELECT * FROM weathers ORDER BY id DESC LIMIT 24) AS t1'
    Rails.cache.fetch('avg', expires_in: 1.minute) do
      ActiveRecord::Base.connection.exec_query(request)[0]['temperature'].round(1)
    end
  end

  def self.by_time(unix_time)
    return { message: '400: Blank time', status: 400 } if unix_time.nil?

    TempByTimeService.new(unix_time).result
  end

  def self.prepared_data(weather)
    {
      time: weather['local_time'],
      temperature: weather['temperature']
    }
  end
end
