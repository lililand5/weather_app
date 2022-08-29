# frozen_string_literal: true

class AllHistoricalService
  def initialize(weathers, date_time)
    @weathers = weathers
    @date_time = date_time
  end

  def result
    DateTime.parse(@date_time)
    # @date_time
  end
end
