class AddIndexBoardTagsOnBoardIdAndTagId < ActiveRecord::Migration[7.0]
  def change
    remove_index :board_tags, :board_id
    remove_index :board_tags, :tag_id
    add_index :board_tags, [:board_id, :tag_id], unique: true
  end
end
