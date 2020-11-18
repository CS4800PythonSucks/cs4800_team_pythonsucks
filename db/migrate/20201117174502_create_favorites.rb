class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.bigint :post_id, null: false
      t.bigint :user_id, null: false
      
      t.timestamps
    end
  end
end
