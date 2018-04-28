class EditPosttagsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :posts_tags do |t|
      t.rename :user_id, :tag_id
    end
  end
end
