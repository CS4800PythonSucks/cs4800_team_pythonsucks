class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :sub_id
      t.string :title
      t.string :url
      t.numeric :votes
      t.string :subreddit
      t.numeric :created

      t.timestamps
    end
  end
end
