class ImportVideoJob < ApplicationJob
  queue_as :default

  IMPORT_DIRECTORY = Rails.root.join('import')

  def perform(path)
    Video.import(path)
  end
end
