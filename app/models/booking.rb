class Booking < ActiveRecord::Base
  has_many :lectureships, dependent: :destroy
  has_many :teachers, through: :lectureships, dependent: :destroy

  belongs_to :course, dependent: :destroy
  belongs_to :room, dependent: :destroy
  belongs_to :timeslot, dependent: :destroy
  belongs_to :group, dependent: :destroy
end
