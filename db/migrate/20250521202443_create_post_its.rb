class CreatePostIts < ActiveRecord::Migration[8.0]
  def change
    create_table :post_its do |t|
      t.text :content
      t.integer :x
      t.integer :y
      t.string :color
      t.string :author
      t.references :whiteboard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
