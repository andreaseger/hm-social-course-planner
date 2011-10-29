class Teacher < ActiveRecord::Base
  has_many :lectureships, dependent: :destroy
  has_many :bookings, through: :lectureships
  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :timeslots, through: :bookings

  validates :name, presence: true, uniqueness: true
  validates :label, presence: true
end
