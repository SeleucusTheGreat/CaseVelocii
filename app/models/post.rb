class Post < ApplicationRecord
    has_many_attached :photos
    belongs_to :user
    has_one :location, dependent: :destroy
    has_many :chat, dependent: :destroy
    accepts_nested_attributes_for :location

    

      scope :price_less_than, ->(price) { where("price <= ?", price) }
      scope :in_city, ->(city) { where(city: city) }
      scope :with_meters, ->(square_meters) { where("square_meters <= ?", square_meters) }
      scope :near_location, ->(address, radius) { near(address, radius) }

    
end
