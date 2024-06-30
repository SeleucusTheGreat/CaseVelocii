class Post < ApplicationRecord
    has_many_attached :photos
    belongs_to :user
    has_many :messages
    has_one :location, dependent: :destroy
    accepts_nested_attributes_for :location

    scope :near_address, ->(address, radius) {
        joins(:location).merge(Location.near(address, radius))
      }

    
end
