# frozen_string_literal: true

module OutputService
  class AllHistoricalService
    def initialize(weathers, date_time)
      @weathers = weathers
      @date_time = date_time
    end

    def result
      # target_time = DateTime.parse(@date_time - 3.hour ).to_i
      target_time = DateTime.parse(@date_time).strftime('%Y-%m-%d %H:%M:%S')
      # @date_time
      # weather_time_list.include?(target_time)

      # weather_time_list
      @weathers.pluck(:local_time)

      # @date_time
    end

    def weather_time_list
      @weathers.pluck(:local_time)
    end
  end
end
