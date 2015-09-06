class Micropost < ActiveRecord::Base
   belongs_to :user
   default_scope -> { order(created_at: :desc) }
   mount_uploader :picture, PictureUploader
   validates :user_id, presence: true
   validates :content, presence: true, length: { maximum: 140 }
   validate  :picture_size  #Note the use of validate (as opposed to validates) to call a custom validation.  #LONG EXPLANATION: file size validation doesn’t correspond to a built-in Rails validator. As a result, validating images requires defining a custom validation, which we’ll call picture_size a
    private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end