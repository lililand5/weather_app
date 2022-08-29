# frozen_string_literal: true

module OutputService
  class TempByTimeService
    def initialize(weathers, date_time)
      @weathers = weathers
      @date_time = date_time
    end

    def result
      return if @weathers.empty?

      times_list = @weathers.pluck(:epoch_time)
      target_time = DateTime.parse(@date_time).to_i
      close_weather(times_list, target_time)
    end

    private

    def close_weather(times_list, target_time)
      if target_time > times_list.last
        'not found datetime!'
      elsif target_time < times_list.first
        @weathers.last
      else
        times = OutputService::BinarySearchService.new.search(times_list, target_time)
        close_time = close_time(times, target_time)
        set_close_weather(close_time)
      end
    end

    def close_time(times, target_time)
      first = (times.first - target_time).abs
      last = (times.last - target_time).abs
      close_time = first < last ? times.first : times.last
      Time.at(close_time).utc.to_datetime
    end

    def find_close_weather(close_time)
      @weathers.find_by(local_time: close_time)
    end
  end
end
