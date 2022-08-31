# frozen_string_literal: true

class ActualizeWeatherService
  URL = "http://dataservice.accuweather.com/currentconditions/v1/#{ENV['KEY_CITY']}/historical/24?apikey=#{ENV['API_KEY']}"

  def actualize
    last_row_from_base = Weather.last
    last_time_from_base = last_row_from_base.nil? ? 0 : last_row_from_base.epoch_time
    weathers_to_db = weathers_to_db(last_time_from_base)
    transform_weathers = transform_weathers(weathers_to_db)

    if transform_weathers.size.positive?
      Weather.create_with(created_at: Time.now, updated_at: Time.now).insert_all(transform_weathers)
    end
    Rails.cache.write('last', Weather.last, expires_in: 60.minutes)
  end

  private

  def weathers_to_db(last_time_from_base)
    weathers_array = prepared_data.select { |weather| weather[:epoch_time] > last_time_from_base }

    weathers_array.sort { |a, b| a[:epoch_time] <=> b[:epoch_time] }
  end

  def transform_weathers(weathers_to_db)
    weathers_to_db.select do |weather|
      weather[:epoch_time].is_a?(Integer) && weather[:temperature].is_a?(Float)
    end
  end

  def prepared_data
    coming_data.map do |data|
      { local_time: data[:LocalObservationDateTime], epoch_time: data[:EpochTime],
        temperature: data[:Temperature][:Metric][:Value].to_f }
    end
  end

  def verified_data
    return { message: '404: Not Found', status: 404 } unless correct_data?(coming_data)
  end

  def correct_data?(coming_data)
    coming_data.nil? || correct_params?(coming_data)
  end

  def correct_params?(coming_data)
    array = coming_data.is_a?(Array)
    hash = coming_data.is_a?(Hash)
    epoch_time = comming_data.first[:EpochTime] =~ /\A\d{10}/
    temperature = comming_data.first[:Temperature][:Metric][:Value]
    return unless array && hash && epoch_time && temperature
  end

  def coming_data
    uri = URI(URL)
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
