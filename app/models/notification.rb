class Notification < ApplicationRecord
    belongs_to :recipient, class_name: 'User'
    belongs_to :sender, class_name: 'User'
    belongs_to :message
    
    scope :unread, -> { where(read: false) }
    scope :read, -> { where(read: true) }
    def mark_as_read
        self.update(read: true)
    end

end