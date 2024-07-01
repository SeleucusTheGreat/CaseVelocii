# app/models/message.rb
class Message < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :chat
    belongs_to :post
  
    validates :content, presence: true
  
    after_create_commit :update_chat_timestamp
  
    private
  
    def update_chat_timestamp
      chat.update(last_message_at: created_at)
    end
  end