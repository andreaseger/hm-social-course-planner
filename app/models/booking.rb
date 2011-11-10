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

  scope :in_conflict_with, -> booking, deliver_current = false {
    unless booking.respond_to? :timeslot
      booking = find(booking)
    end
    if deliver_current
      where timeslot_id: booking.timeslot.id
    else
      where "timeslot_id = ? AND id != ?", booking.timeslot.id, booking.id
    end
  }
  scope :related_to, -> booking, deliver_current = false {
    unless booking.respond_to? :course
      booking = find(booking)
    end
    if deliver_current
      where course_id: booking.course.id
    else
      where "course_id = ? AND id != ?", booking.course.id, booking.id
    end
  }
  scope :in_conflict_with_any_related, -> booking {
    unless booking.respond_to? :course
      booking = find(booking)
    end
    #where "timeslot_id IN ( SELECT timeslot_id FROM bookings WHERE bookings.course_id = ? )", booking.course.id
    #TODO - not really happy with this solution, find a way without a second select
    a = related_to(booking,true)
    where "timeslot_id IN ( ? ) AND id NOT IN ( ? )", a.map(&:timeslot_id), a.map(&:id)
  }
  scope :without_conflict, -> bookings {
    where "timeslot_id NOT IN ( ? )", bookings.map(&:timeslot_id)
  }

  def find_conflicted(deliver_current = false)
    Booking.in_conflict_with(self,deliver_current)
  end
  def find_related(deliver_current = false)
    Booking.related_to(self,deliver_current)
  end
  def find_related_with_conflict
    Booking.in_conflict_with_any_related(self)
  end

  def as_json(options={})
    options ||= { methods: [:teachers, :room, :course, :timeslot, :group ],
                  except: [:created_at, :updated_at] }
    super(options)
  end
end
