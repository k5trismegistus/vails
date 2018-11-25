class TaggingsController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    tag = Tag.find_or_create_by(content: params[:tag_content])

    Tagging.create!(video_id: video.id, tag_id: tag.id)

    @taggings = video.taggings
    respond_to do |format|
      format.js { render :create }
    end
  end

  def destroy
    tagging = Tagging.find(params[:id])
    tagging.destroy
    video = tagging.video
    @taggings = video.taggings

    respond_to do |format|
      format.js { render :destroy }
    end
  end
end
