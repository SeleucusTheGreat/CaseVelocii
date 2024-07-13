class Post < ApplicationRecord
    has_many_attached :photos
    belongs_to :user
    has_one :location, dependent: :destroy
    has_many :chat, dependent: :destroy
    accepts_nested_attributes_for :location
    validate :validate_photos_count
    

      scope :price_less_than, ->(price) { where("price <= ?", price) }
      scope :in_city, ->(city) { where(city: city) }
      scope :with_meters, ->(square_meters) { where("square_meters <= ?", square_meters) }
      scope :near_location, ->(address, radius) { 
        loc = Location.new(address: address)
        result = loc.geocode
        if result.nil?
          none
        else
          locations =Location.near(result, radius) 
          joins(:location).where(locations: { id: locations.map(&:id) })
        end
      }

      

      private
    
      def validate_photos_count
        if photos.size > 10
          errors.add(:photos, "You can upload a maximum of 10 photos.")
        end
      end
end
