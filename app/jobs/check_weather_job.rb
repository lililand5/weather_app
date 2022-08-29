# frozen_string_literal: true

class CheckWeatherJob
  include Sidekiq::Job

  def perform
    ActualizeWeatherJob.perform_later
  end
end
