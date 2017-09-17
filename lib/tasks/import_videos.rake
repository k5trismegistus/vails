namespace :import_videos do
  desc '未インポートの動画をすべてインポートする'
  task :do => :environment do
    IMPORT_DIRECTORY = Rails.root.join('import')

    paths = Dir.entries(IMPORT_DIRECTORY)
      .select { |f| f.match(/.+\.mp4$/) }
      .map{ |f| Pathname.new(IMPORT_DIRECTORY).join(f).to_s }

    paths.each { |p| ImportVideoJob.perform_later p}
  end
end
