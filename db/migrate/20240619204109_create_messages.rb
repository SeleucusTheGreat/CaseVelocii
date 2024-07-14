
class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :chat, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end


  end
end