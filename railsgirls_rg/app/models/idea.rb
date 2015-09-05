class Idea < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  has_many :comments
  validates :name, presence: true

end
