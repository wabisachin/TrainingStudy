class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :front_word
      t.string :back_word
      t.string :category_id
      t.timestamps
    end
  end
end
