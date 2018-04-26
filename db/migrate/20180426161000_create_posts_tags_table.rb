class CreatePostsTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts_tags do |t|
      t.integer :user_id
      t.integer :post_id
    end
  end
end
