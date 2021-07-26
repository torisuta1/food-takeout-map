class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true
      

      t.timestamps
    end
    add_index :posts, [:created_at]
  end
end
