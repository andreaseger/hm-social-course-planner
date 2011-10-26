class Timeslot < ActiveRecord::Base
  belongs_to :day, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings
end
