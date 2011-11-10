class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :classmate, class_name: 'User', foreign_key: 'classmate_id'

  validates :user, presence: true
  validates :classmate, presence: true#, uniquess: {scope: :user}

  def self.accept(user, classmate)
    r = where(user_id: user.id).where(classmate_id: classmate.id).first
    r.accept! if r
  end

  def accept!
    self.accepted = true
    self.save
  end
  def discard!
    self.accepted = false
    self.save
  end
  def accepted?
    self.accepted
  end
end
