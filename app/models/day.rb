class Day < ActiveRecord::Base
  has_many :timeslots, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :label, presence: true
end
