class TagsController < ApplicationController
  def index
    @tags = Tag.includes(:videos).page(params[:page]).per(20)
  end
end