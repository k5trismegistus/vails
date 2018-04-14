class CreateForeignKeyConstraint < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :taggings, :videos, column: :video_id, on_delete: :cascade
  end
end
