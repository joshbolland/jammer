class Jam < ApplicationRecord
  belongs_to :user
  has_many :slots
  validate :title, presence: true
  validate :description, presence: true
  validate :date, presence: true
  validate :location, presence: true
end
