# frozen_string_literal: true

module OutputService
  class TempByTimeService
    def initialize(weathers, date_time)
      @weathers = weathers
      @date_time = date_time
    end

    def result
      times_list = @weathers.pluck(:epoch_time)
      target_time = DateTime.parse(@date_time).to_i
      times = OutputService::BinarySearchService.new.search(times_list, target_time)
      unix_time = set_close_time(times, target_time)

      Time.at(unix_time).utc.to_datetime
    end

    def set_close_time(times, target_time)
      first = (times.first - target_time).abs
      last = (times.last - target_time).abs

      first < last ? times.first : times.last
    end
  end
end
