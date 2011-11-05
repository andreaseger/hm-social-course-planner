class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy
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
end
