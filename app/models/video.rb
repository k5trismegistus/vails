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
end
