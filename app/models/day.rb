class Day < ActiveRecord::Base
  has_many :timeslots, dependent: :destroy
end
