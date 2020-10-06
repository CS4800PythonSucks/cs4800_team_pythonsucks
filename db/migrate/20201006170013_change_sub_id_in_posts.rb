class ChangeSubIdInPosts < ActiveRecord::Migration[6.0]
  def change
    change_column_null :posts, :sub_id, false
  end
end
