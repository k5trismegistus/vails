class VideosController < ApplicationController
  def index
    unless params[:tag].present?
      @videos = Video.order(:id).page(params[:page]).per(20)
    else
      @tag = Tag.find_by(content: params[:tag])
      @videos = @tag.videos.order(:id).page(params[:page]).per(20)
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to '/'
  end
end
