class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar
  has_many :posts

  has_many :chats_as_user1, class_name: 'Chat', foreign_key: 'user1_id'
  has_many :chats_as_user2, class_name: 'Chat', foreign_key: 'user2_id'
  has_many :messages, foreign_key: 'sender_id'
  has_many :received_notifications, class_name: 'Notification', foreign_key: 'recipient_id'
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id'
  
  def chats
    Chat.where('user1_id = :user_id OR user2_id = :user_id', user_id: id)
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.aid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.full_name = auth.info.name 
      user.avatar_url = auth.info.image
    end
  end

  def admin?
    admin
  end

  
end
