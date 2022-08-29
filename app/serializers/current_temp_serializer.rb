# frozen_string_literal: true

class CurrentTempSerializer < ActiveModel::Serializer
  attributes :current_temperature

  def current_temperature
    {
      time: DateTime.parse(object.local_time.to_s).strftime('%Y-%m-%d %H:%M:%S %z'),

      temperature: object.temperature
    }
  end
end
