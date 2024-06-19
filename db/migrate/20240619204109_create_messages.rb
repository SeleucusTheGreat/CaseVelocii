class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :receiver, foreign_key: { to_table: :users }, null: false
      t.references :post, foreign_key: true , null: false
      t.timestamps
    end
  end
end
