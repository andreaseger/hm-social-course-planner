class Booking < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :course
  belongs_to :room
  belongs_to :teacher
  belongs_to :timeslot
end
