# frozen_string_literal: true

module OutputService
  class CalculateService
    def initialize(weathers, data_type)
      @weathers = weathers
      @data_type = data_type
    end

    def result
      temp_array = prepare_temp
      case @data_type
      when 'max_temp'
        temp_array.max
      when 'min_temp'
        temp_array.min
      when 'avg_temp'
        (temp_array.sum / temp_array.size).round(1)
      end
    end

    private

    def prepare_temp
      @weathers.map(&:temperature)
    end
  end
end
