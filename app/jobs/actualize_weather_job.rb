# frozen_string_literal: true

class ActualizeWeatherJob
  include Sidekiq::Job

  def perform
    puts '# Do something!!!'
  end
end
