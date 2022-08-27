# frozen_string_literal: true

class MainController < ApplicationController
  def health
    render json: { status: 'OK' }
  end
end
