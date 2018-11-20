class Request < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  validates :status, inclusion: { in: %w(accepted pending declined),
    message: "%{value} is not a valid status" } 
end
