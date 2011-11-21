class Profile < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  def fullname
    "#{firstname} #{lastname}" if firstname || lastname
  end
end
