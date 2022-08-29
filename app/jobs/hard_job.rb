# frozen_string_literal: true

class HardJob
  include Sidekiq::Job

  def perform
    puts '# Do something!!!'
  end
end
