# frozen_string_literal: true

module OutputService
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

    private

    def list_history_temperature
      @weathers.map do |weather|
        {
          time: weather.local_time.strftime('%Y-%m-%d %H:%M:%S'),
          temperature: weather.temperature
        }
      end
    end
  end
end
