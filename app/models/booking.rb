class Booking < ActiveRecord::Base
  has_many :lectureships, dependent: :destroy
  has_many :teachers, through: :lectureships

  belongs_to :course
  belongs_to :room
  belongs_to :timeslot
  belongs_to :group

  validates :course, presence: true
  validates :room, presence: true
  validates :timeslot, presence: true
  validates :group, presence: true
end
