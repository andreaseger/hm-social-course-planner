class Teacher < ActiveRecord::Base
  has_many :lectureships, dependent: :destroy
  has_many :bookings, through: :lectureships

  #SELECT * FROM teachers t
  #  INNER JOIN bookings_teachers bt on t.id=bt.teacher_id
  #  INNER JOIN bookings b on b.id=bt.bookings_id
  #  INNER JOIN rooms r on r.id=b.room_id

  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :timeslots, through: :bookings
end
