class Timeslot < ActiveRecord::Base
  belongs_to :day
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings
  has_many :rooms, through: :bookings
  has_many :teachers, through: :bookings

  validates_presence_of :day, :start_label, :end_label

  validates :start_minute, numericality: { only_integer: true, less_than: 60, greater_than_or_equal_to: 0 }, presence: true
  validates :end_minute, numericality: { only_integer: true, less_than: 60, greater_than_or_equal_to: 0 }, presence: true

  validates :start_hour, numericality: { only_integer: true, less_than: 24, greater_than_or_equal_to: 0 }, presence: true
  validates :end_hour, numericality: { only_integer: true, less_than: 24, greater_than_or_equal_to: 0 }, presence: true

  def start_time
    warn '[DEPRECATION] use start_minute/start_hour instead of start_time'
    start_hour*100+start_minute
  end

  def end_time
    warn '[DEPRECATION] use end_minute/end_hour instead of end_time'
    end_hour*100+end_minute
  end

  def length
    (end_hour*60+end_minute)-(start_hour*60+start_minute)
  end

  def as_json(options=nil)
    options ||= { methods: [:day, :length], except: [:created_at, :updated_at] }
    super(options)
  end

  def self.now
    t=Time.now
    day_id = t.wday # 0..6, with Sunday == 0
    fuzzy_start_hour = [ (t.hour-1)%24, t.hour, (t.hour+1)%24 ]
    where(day_id: day_id).where(start_hour: [ (t.hour-1)%24, t.hour, (t.hour+1)%24 ])
  end
end
