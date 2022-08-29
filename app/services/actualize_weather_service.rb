# frozen_string_literal: true

class ActualizeWeatherService
  URL = 'http://dataservice.accuweather.com/currentconditions/v1/294021/historical/24'
  API_KEY = '10MV1FEulA3c3AoKzzrfJRGQVtBpE3Yw'

  def actualize
    last_row_from_base = Weather.last
    last_time_from_base = last_row_from_base.nil? ? 0 : last_row_from_base.epoch_time
    weathers_to_db = weathers_to_db(last_time_from_base)

    return nil if weathers_to_db.empty?

    Weather.create_with(created_at: Time.now, updated_at: Time.now).insert_all(weathers_to_db)
  end

  def prepared_data
    coming_data.map do |data|
      { local_time: data[:LocalObservationDateTime], epoch_time: data[:EpochTime],
        temperature: data[:Temperature][:Metric][:Value] }
    end
  end

  def weathers_to_db(last_time_from_base)
    weathers_array = prepared_data.select { |weather| weather[:epoch_time] > last_time_from_base }

    weathers_array.sort { |a, b| a[:epoch_time] <=> b[:epoch_time] }
  end

  def coming_data
    uri = URI("#{URL}?apikey=#{API_KEY}")
    request = Net::HTTP::Get.new(
      uri
    )
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
