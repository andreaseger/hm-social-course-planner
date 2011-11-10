class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :classmates, through: :relationships

  has_one :schedule
  has_one :profile, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true

  scope :with_role, -> role {
    where "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "
  }

  # only important thing here is that you cant remove roles or reorder them,
  # this would mess up the mask
  ROLES = %w[ admin ]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def self.create_from_hash!(hash)
    create( username: hash['info']['name'], email: hash['info']['email'] )
  end


  scope :with_classmate_requests, -> user {
    joins(:relationships).where("relationships.classmate_id = ?", user.id ).where("relationships.user_id != ?",user.id)
  }
  #scope :accepted_classmates, -> user {
  #  joins(:relationships).where("( relationships.classmate_id != ? AND relationships.user_id = ? ) OR ( relationships.classmate_id = ? AND relationships.user_id != ? )",user.id, user.id, user.id, user.id )
  #}

  def classmate_requests
    User.with_classmate_requests(self).reject{|e| e.is_classmate_with(self) }
  end
  def pending_classmates
    self.classmates.reject{|e| e.is_classmate_with(self) }
  end
  def accepted_classmates
    classmates.where("users.id IN (SELECT user_id FROM relationships where classmate_id = ?) ", id)
  end
  def add_classmate(mate)
    return if mate == self
    self.classmates << mate unless self.classmates.include?(mate)
  end
  def is_classmate_with(mate)
    accepted_classmates.include?(mate)
  end
end
