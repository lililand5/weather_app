# frozen_string_literal: true

FactoryBot.define do
  factory :list_last_weathers, class: Array do
    data = {
        time: DateTime.now,
        temperature: 23.5
      }

    initialize_with do
      [data, data]
    end
  end
end
