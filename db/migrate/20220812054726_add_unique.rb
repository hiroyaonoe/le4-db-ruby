class AddUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :name, unique: true
    add_index :tags, :name, unique: true
  end
end
