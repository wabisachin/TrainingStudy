class AddWeaknessToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :weakness, :integer, default: 0
    remove_column :cards, :favorite, :integer
  end
end
