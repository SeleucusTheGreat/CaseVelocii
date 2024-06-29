class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :city , null:false
      t.float :price
      t.integer :numer_rooms
      t.float :square_feet
      t.integer :floor
      t.references :user, foreign_key: true , null: false
      t.timestamps
    end
  end
end
