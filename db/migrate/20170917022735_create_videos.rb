class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :filename
      t.string :md5
      t.string :thumbnail_filename
      t.timestamps
    end

    add_index :videos, :md5
  end
end
