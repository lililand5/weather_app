class MainController < ApplicationController
  def index
    render json: "123"
  end

  def health
    render json: { status: 'OK' }
  end
end
