class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :view_count
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
