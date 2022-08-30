# frozen_string_literal: true

FactoryBot.define do
  factory :weather do
    local_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    epoch_time { 1_234_567_890 }
    temperature { 23.5 }
  end
end
