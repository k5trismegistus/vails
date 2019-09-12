module Importable
  extend ActiveSupport::Concern

  class AlreadyImportedVideo < StandardError; end

  VIDEO_DIR = Rails.root.join('public/imported_videos')
  THUMBNAIL_DIR = Rails.root.join('public/thumbnails')

  class_methods do
    def import(path)
      file = File.open(path) do |f|
        md5 = Digest::MD5.file(f).to_s
        raise AlreadyImportedVideo if Video.find_by(md5: md5).present?

        d = `ffprobe -i "#{path}" -show_entries format=duration -print_format json  -loglevel quiet`
        duration = JSON.parse(d)['format']['duration'].to_i

        Dir.mktmpdir(nil, Rails.root.join('tmp')) do |dir|
          (0..9).each do |i|
            `ffmpeg -ss #{(duration * i / 10).to_i} -t 1 -r 1 -i "#{path}" -f image2 -s 640x360 #{dir}/img_#{sprintf('%02d', i)}.jpg`
          end
          `convert -delay 40 -loop 0 #{dir}/img_*.jpg #{THUMBNAIL_DIR}/#{md5}.gif`
        end
        FileUtils.copy(path, VIDEO_DIR)

        filename = path.split('/').last

        FileUtils.chmod(0666, File.join(VIDEO_DIR, filename))

        Video.create!(
          filename: filename,
          md5: md5,
          thumbnail_filename: "#{md5}.gif"
        )
      end
    end
  end
end
