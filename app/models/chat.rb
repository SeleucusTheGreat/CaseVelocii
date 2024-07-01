# app/models/chat.rb
class Chat < ApplicationRecord
    belongs_to :post
    belongs_to :user1, class_name: 'User'
    belongs_to :user2, class_name: 'User'
    has_many :messages
  
    validates :user1_id, uniqueness: { scope: [:post_id, :user2_id] }
  
    def other_user(current_user)
      current_user == user1 ? user2 : user1
    end
  end