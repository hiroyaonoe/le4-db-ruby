class ChangeColumnNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :name, false
    change_column_null :boards, :title, false
    change_column_null :comments, :content, false
    change_column_null :categories, :name, false
    change_column_null :tags, :name, false
  end
end
