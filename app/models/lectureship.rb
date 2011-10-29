class Lectureship < ActiveRecord::Base
  belongs_to :booking, dependent: :destroy
  belongs_to :teacher
end
