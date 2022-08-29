# frozen_string_literal: true

class ActualizeWeatherService
  attr_reader :result

  def initialize
    @result = {}
  end

  def set_current_temp
    @result[:current_temp] = current_data.first[:Temperature][:Metric][:Value]
  end

  def current_data
    uri = URI('http://dataservice.accuweather.com/currentconditions/v1/294021?apikey=7kx9wNbNxzrxzTuwUZAwWaf6uCXLrVV5')
    request = Net::HTTP::Get.new(
      uri
    )
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
