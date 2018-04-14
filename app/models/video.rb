# == Schema Information
#
# Table name: videos
#
#  id                 :integer          not null, primary key
#  filename           :string
#  md5                :string
#  thumbnail_filename :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Video < ApplicationRecord
  include Importable

  has_many :taggings
  has_many :tags, through: :taggings

  before_destroy :delete_files

  VIDEO_DIR = Rails.root.join('public/imported_videos')
  THUMBNAIL_DIR = Rails.root.join('public/thumbnails')


  private
  def delete_files
    File.delete("#{VIDEO_DIR}/#{filename}")
    File.delete("#{THUMBNAIL_DIR}/#{thumbnail_filename}")
  end
end
