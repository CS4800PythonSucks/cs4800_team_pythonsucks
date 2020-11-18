class AddForeignKeyToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :favorites, :posts
    add_foreign_key :favorites, :users
  end
end
