class VideosController < ApplicationController
  def index
    @videos = Video.page(params[:p]).per(20)
  end

  def show
    @video = Video.find(params[:id])
  end
end
