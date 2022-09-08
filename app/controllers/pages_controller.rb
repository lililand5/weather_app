class PagesController < ApplicationController

  def index
    # render plain: "123"
  end

  def show
    Page.find_by(id: params[:id])
  end

  def create
    Page.create title: params[:title]
  end
end
