class Message < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :receiver, class_name: "User"
    belongs_to :post, class_name: "Post"
    validates :content, presence: true
end
  