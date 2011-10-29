class Timeslot < ActiveRecord::Base
  belongs_to :day
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings

  validates :start_label, presence: true, uniqueness: true
  validates :end_label, presence: true, uniqueness: true
  validates :start_time, presence: true, uniqueness: true
  validates :end_time, presence: true, uniqueness: true
  validates :day, presence: true
end
