# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :taggings
  has_many :videos, through: :taggings
end
