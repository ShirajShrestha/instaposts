class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :description

      t.timestamps null: false
    end
    add_index :posts, :user_id
  end
end
