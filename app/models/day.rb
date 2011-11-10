class Day < ActiveRecord::Base
  has_many :timeslots, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :label, presence: true

  def as_json(options={})
    options ||= { except: [:created_at, :updated_at] }
    super(options)
  end
end
