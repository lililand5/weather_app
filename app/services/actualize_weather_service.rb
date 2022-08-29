# frozen_string_literal: true

class ActualizeWeatherService
  def actualize
    last_row_from_base = Weather.last
    last_time_from_base = if last_row_from_base.nil?
                            0
                          else
                            last_row_from_base.epoch_time
                          end

    prepared_hash = coming_data.map do |data|
      { local_time: data[:LocalObservationDateTime], epoch_time: data[:EpochTime],
        temperature: data[:Temperature][:Metric][:Value] }
    end

    weathers_to_db = prepared_hash.select { |weather| weather[:epoch_time] > last_time_from_base }

    weathers_to_db = weathers_to_db.sort { |a, b| a[:epoch_time] <=> b[:epoch_time] }

    return nil if weathers_to_db.empty?

    Weather.create_with(created_at: Time.now, updated_at: Time.now).insert_all(weathers_to_db)
  end

  def coming_data
    uri = URI('http://dataservice.accuweather.com/currentconditions/v1/294021/historical/24?apikey=10MV1FEulA3c3AoKzzrfJRGQVtBpE3Yw')
    request = Net::HTTP::Get.new(
      uri
    )
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
