# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.datetime :weather_time
      t.float :temperature
      t.timestamps
    end
  end
end
