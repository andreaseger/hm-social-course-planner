class Group < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings

  validates :name, presence: true, uniqueness: true
end
