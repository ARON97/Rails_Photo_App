class Image < ApplicationRecord
  belongs_to :user
  # Using carrierwave to associate the image with the user
  mount_uploader :picture, PictureUploader
  # Image size validations
  validate :picture_size

  private 

  def picture_size
  	if picture.size > 5.megabytes
  		errors.add(:picture, "should be less than 5MB")
  	end
  end
end
