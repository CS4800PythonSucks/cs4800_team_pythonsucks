class AddBrokenToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :broken, :bool, default: false
  end
end
