class AddReportedToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :reported, :bool, default: false
  end
end
