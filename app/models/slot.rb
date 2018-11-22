class Slot < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :jam
  belongs_to :instrument
  has_many :requests, dependent: :destroy
end
