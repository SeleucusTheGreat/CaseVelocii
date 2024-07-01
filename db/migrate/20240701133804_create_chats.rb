class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user1, null: false, foreign_key: { to_table: :users }
      t.references :user2, null: false, foreign_key: { to_table: :users }
      t.datetime :last_message_at

      t.timestamps
    end

    add_index :chats, [:post_id, :user1_id, :user2_id], unique: true

    # Remove receiver_id from messages table if it exists
    if column_exists?(:messages, :receiver_id)
      remove_column :messages, :receiver_id, :integer
    end

    # Add chat_id to messages table if it doesn't exist
    unless column_exists?(:messages, :chat_id)
      add_reference :messages, :chat, null: false, foreign_key: true
    end
  end
end