class Schedule < ActiveRecord::Base
  has_and_belongs_to_many :bookings
  belongs_to :user

  validates :user, presence: true

  def bookings_without_conflict
    Booking.find_conflict_free(self.bookings)
  end
end
