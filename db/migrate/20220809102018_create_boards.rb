class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
