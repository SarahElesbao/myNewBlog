class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :tittle
      t.text :content
      t.text :image
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
