class Timeslot < ActiveRecord::Base
  belongs_to :day
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings

  validates :start_label, presence: true
  validates :end_label, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day, presence: true

  def as_json(options=nil)
    options ||= { methods: :day, except: [:created_at, :updated_at] }
    super(options)
  end
end
