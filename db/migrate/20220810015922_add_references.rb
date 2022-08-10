class AddReferences < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards,   :user_id
    add_reference :boards,   :user,     foreign_key: true
    remove_column :boards,   :category_id
    add_reference :boards,   :category, foreign_key: true
    remove_column :comments, :user_id
    add_reference :comments, :user,     foreign_key: true
    remove_column :comments, :board_id
    add_reference :comments, :board,    foreign_key: true
  end
end
