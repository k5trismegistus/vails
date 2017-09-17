module Importable
  extend ActiveSupport::Concern

  class AlreadyImportedVideo < StandardError; end

  VIDEO_DIR = Rails.root.join('public/imported_videos')
  THUMBNAIL_DIR = Rails.root.join('public/thumbnails')

  class_methods do
    def extract_scenes

    end

    def import(path)
      file = File.open(path) do |f|
        md5 = Digest::MD5.file(f).to_s
        raise AlreadyImportedVideo if Video.find_by(md5: md5).present?

        v = FFMPEG::Movie.new(path)

        Dir.mktmpdir(nil, Rails.root.join('tmp')) do |dir|
          (0..9).each do |i|
            v.screenshot("#{dir}/img_#{sprintf('%02d', i)}.jpg", { seek_time: ( v.duration * i / 10), resolution: '640x360'}, preserve_aspect_ratio: :height)
            `convert -delay 40 -loop 0 #{dir}/img_*.jpg #{THUMBNAIL_DIR}/#{md5}.gif`
          end
        end
        FileUtils.copy(path, VIDEO_DIR)

        Video.create!(
          filename: path.split('/').last,
          md5: md5,
          thumbnail_filename: "#{md5}.gif"
        )
      end
    end
    end
end
