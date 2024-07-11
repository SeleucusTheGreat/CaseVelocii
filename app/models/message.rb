# app/models/message.rb
class Message < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :chat
    belongs_to :post
    has_one :notification, dependent: :destroy
    validates :content, presence: true
  
    after_create_commit :update_chat_timestamp, :create_notification
  
    private
  
    def create_notification
      recipient = chat.user1_id == sender_id ? chat.user2 : chat.user1
      notif = Notification.create(
        recipient: recipient,
        sender: sender,
        message: self,
        read: false
      )
      self.notification = notif
    end
    
    def update_chat_timestamp
      chat.update(last_message_at: created_at)
    end
  end