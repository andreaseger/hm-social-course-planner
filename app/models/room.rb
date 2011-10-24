class Room < ActiveRecord::Base
  has_many :bookings
  has_many :courses, through: :bookings
  has_many :schedules, through: :bookings
  has_many :teachers, through: :bookings
  has_many :timeslots, through: :bookings
end
