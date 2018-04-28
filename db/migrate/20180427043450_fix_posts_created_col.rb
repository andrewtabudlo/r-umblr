class FixPostsCreatedCol < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
      t.rename :create_at, :created_at
    end
  end
end
