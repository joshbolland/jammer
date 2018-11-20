class UserInstrument < ApplicationRecord
  belongs_to :user
  belongs_to :instrument
  validates_uniqueness_of :user_id, :scope => :instrument_id
end
