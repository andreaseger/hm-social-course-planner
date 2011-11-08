class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :classmate, class_name: 'User', foreign_key: 'user_id'

  validates :user, presence: true
  validates :classmate, presence: true#, uniquess: {scope: :user}

  def self.accept(user, classmate)
    where(user: [user.id, classmate.id]).each do |relationship|
      relationship.accept
    end
  end

  def accept
    self.accepted = true
  end
  def discard
    self.accepted = false
  end
  def accepted?
    self.accepted
  end
end
