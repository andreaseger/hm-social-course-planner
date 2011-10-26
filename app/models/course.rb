class Course < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings
  has_many :timeslots, through: :bookings
end
