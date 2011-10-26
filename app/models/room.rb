class Room < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings
  has_many :teachers, through: :bookings
  has_many :timeslots, through: :bookings
end
