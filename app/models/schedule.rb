class Schedule < ActiveRecord::Base
  has_many :bookings
  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings
end
