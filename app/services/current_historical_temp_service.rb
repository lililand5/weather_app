# frozen_string_literal: true

class CurrentHistoricalTempService
  def initialize(weathers)
    @weathers = weathers
  end

  def result(data_type)
    if data_type == 'all_history'
      list_history_temperature
    else
      CalculateService.new(@weathers, data_type).result
    end
  end

  def list_history_temperature
    @weathers.map do |weather|
      {
        time: weather.local_time,
        temperature: weather.temperature
      }
    end
  end
end
