class Schedule < ActiveRecord::Base
  has_and_belongs_to_many :bookings
  belongs_to :user

  validates :user, presence: true

  def bookings_without_conflict
    Booking.without_conflict(self.bookings)
  end
  def fill_with_related!
    new_bookings = bookings.map{ |e| Booking.related_to(e) }.flatten
    self.bookings << new_bookings.reject{|e| self.bookings.include? e }
  end
end
