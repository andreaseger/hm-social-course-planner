class Room < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings
  has_many :teachers, through: :bookings
  has_many :timeslots, through: :bookings

  validates :name, presence: true, uniqueness: true
  validates :label, presence: true
  validates :building, presence: true
  validates :floor, presence: true

  def as_json(options=nil)
    options ||= { only: [:id, :label, :name] }
    super(options)
  end
end
