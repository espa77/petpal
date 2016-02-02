class AddFavoriteIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :favorite_id, :integer
  end
end
