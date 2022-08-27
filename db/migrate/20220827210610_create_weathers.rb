# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.string :city
      t.string :current_temp
      t.string :historical
      t.float :historical_max
      t.float :historical_min
      t.float :historical_avg
      t.timestamps
    end
  end
end
