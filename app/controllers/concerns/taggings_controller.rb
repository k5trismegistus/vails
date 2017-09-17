class TaggingsController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    tag = Tag.find_or_create_by(content: params[:tag_content])

    Tagging.create!(video_id: video.id, tag_id: tag.id)
  end

  def destroy
    Tagging.destroy(params[:id])
  end
end
