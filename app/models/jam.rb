class Jam < ApplicationRecord
  belongs_to :user
  has_many :slots
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  mount_uploader :photo, PhotoUploader
end
