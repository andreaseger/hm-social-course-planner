class Booking < ActiveRecord::Base
  has_many :lectureships, dependent: :destroy
  has_many :teachers, through: :lectureships

  has_and_belongs_to_many :schedules

  belongs_to :course
  belongs_to :room
  belongs_to :timeslot
  belongs_to :group

  validates :room, presence: true
  validates :course, presence: true
  validates :timeslot, presence: true
  validates :group, presence: true
  validates :teachers, presence: true

  def find_conflicted(deliver_current = true)
    Booking.find_conflicted(self,deliver_current)
  end

  def self.find_conflicted(booking, deliver_current = true)
    unless booking.respond_to? :timeslot
      booking = find(booking)
    end
    if deliver_current
      where timeslot_id: booking.timeslot.id
    else
      where "timeslot_id = ? AND id != ?", booking.timeslot.id, booking.id
    end
  end

  def find_related(deliver_current = true)
    Booking.find_related(self,deliver_current)
  end

  def self.find_related(booking, deliver_current = true)
    unless booking.respond_to? :course
      booking = find(booking)
    end
    if deliver_current
      where course_id: booking.course.id
    else
      where "course_id = ? AND id != ?", booking.course.id, booking.id
    end
  end

  def find_related_with_conflict
    Booking.find_related_with_conflict(self)
  end
  def self.find_related_with_conflict(booking)
    unless booking.respond_to? :course
      booking = find(booking)
    end
    where "timeslot_id IN ( SELECT timeslot_id FROM bookings WHERE bookings.course_id = ? )", booking.course.id
  end
end
