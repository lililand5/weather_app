# frozen_string_literal: true

# require 'sanitize'

class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    Page.find_by(id: params[:id])
  end

  def create
    # sanitize_params = Sanitize.fragment(params[:title])
    sanitize_params = params[:title]
    Page.create title: sanitize_params
    redirect_to action: "index"
  end
end
