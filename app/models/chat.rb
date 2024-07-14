# app/models/chat.rb
class Chat < ApplicationRecord
    belongs_to :post
    belongs_to :buyer, class_name: 'User'
    belongs_to :owner, class_name: 'User'
    has_many :messages, dependent: :destroy
  
    validates :buyer, uniqueness: { scope: [:post_id, :owner] }
  
    def other_user(current_user)
      current_user == buyer ? owner : buyer
    end
  end