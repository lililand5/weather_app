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
    # sanitize_params = params[:title]
    Page.create user_id: params[:user_id], article_id: params[:article_id], text: params[:text]
    redirect_to action: "index"
  end

  def destroy
    Page.find_by(id: params[:id]).destroy
    redirect_to action: "index"
  end
end
