require 'open-uri'

class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_save :generate_map_image
  has_one_attached :map_image

  def generate_map_image
    # Only generate the map if geocoding was successful
    return unless latitude.present? && longitude.present?

    # Check if the map image is already attached
    unless map_image.attached?
      # Generate the static map URL
      static_map_url = "https://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=400x400&maptype=roadmap&markers=color:red%7Clabel:S%7C#{latitude},#{longitude}&key=#{Rails.application.credentials.dig(:GOOGLE_MAPS_API_KEY)}"

      # Download and attach the image
      begin
        downloaded_image = URI.open(static_map_url)
        map_image.attach(io: downloaded_image, filename: "#{id}.png")
      rescue => e
        Rails.logger.error "Failed to download map image: #{e.message}"
      end
    end
  end
end
