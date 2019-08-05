class AddFavoriteToCards < ActiveRecord::Migration[5.2]
  def change
    # デフォルト値を設定(1:unfavorite 2:favorite)
    add_column :cards, :favorite, :integer, null:false, default: 0
  end
end
