class CreateCommentsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :post_id
      t.integer :user_id
    end
  end
end
