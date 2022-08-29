# frozen_string_literal: true

class ActualizeWeatherJob
  include Sidekiq::Job

  def perform
    service = ReceivingService::ActualizeWeatherService.new
    service.actualize
  end
end
