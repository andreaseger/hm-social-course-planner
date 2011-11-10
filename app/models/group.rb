class Group < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings

  validates :name, presence: true, uniqueness: true

  def as_json(options={})
    options ||= { except: [:created_at, :updated_at] }
    super(options)
  end
end
