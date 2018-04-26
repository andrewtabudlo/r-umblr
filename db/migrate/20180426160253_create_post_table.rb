class CreatePostTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.datetime :create_at
      t.datetime :updated_at 
      t.integer :user_id
    end
  end
end
