# frozen_string_literal: true

class TakeActualWeatherService
  # attr_reader :result

  # def initialize
  #   @result = {}
  # end

  def check_last_weather
    if Weather.last.nil?
      take_all_temp # берет все температуры за 24 часа
    elsif old_time? # проверят время последней температуры с текущим временем
      add_missing_records # проверяет сколько записей не хватает в базе
    else # если последняя температура совпадает с текущим часом - возвращать nil
      nil
    end
  end

  def add_missing_records
    number_of_records # считает сколько часов упущено. Сколько упущено, сколько и взять из хэша
  end

  def number_of_records
  end

  def old_time?
  end

  def take_all_temp
    # take_temp # делает запись в базу
    all_data.each do |data|
      Weather.create weather_time: data[:LocalObservationDateTime], temperature: data[:Temperature][:Metric][:Value]
    end
  end

  def take_temp

  end


  # # Занести в базу актуальные температуры за 24 часа
  def create_weather
    # @result[:current_temp] = current_data.first[:Temperature][:Metric][:Value]

  end

  # взять атуальные температуры с сайта
  def all_data
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
