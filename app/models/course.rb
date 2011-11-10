class Course < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings
  has_many :timeslots, through: :bookings

  validates :name, presence: true, uniqueness: true
  validates :label, presence: true

  def as_json(options={})
    options ||= { except: [:created_at, :updated_at] }
    super(options)
  end
end
