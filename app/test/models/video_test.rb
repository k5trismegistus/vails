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

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
