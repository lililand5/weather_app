# frozen_string_literal: true

FactoryBot.define do
  factory :weather do
    local_time { Faker::Time.between(from: DateTime.now - 5, to: DateTime.now) }
    epoch_time { local_time.to_i }
    temperature { (-20..20).to_a.sample }
  end
end
