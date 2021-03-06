class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :classmates, through: :relationships

  has_one :schedule, dependent: :destroy
  has_one :profile, dependent: :destroy
  before_create :build_default_profile_and_schedule

  validates :username, presence: true

  scope :with_classmate_requests, -> user {
    joins(:relationships).where("relationships.classmate_id = ?", user.id ).where("relationships.user_id != ?",user.id)
  }
  scope :accepted_classmates, -> user {
    user.accepted_classmates
  }

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
    info = OpenStruct.new hash['info']

    case hash['provider']
    when 'twitter'
      u = create( username: info.nickname )
      u.profile.update_attributes(firstname: info.name, bio: info.description, twitter: info.nickname, website: info.urls["Twitter"] )
      u
    when 'facebook'
      u = create( username: info.nickname, email: info.email)
      u.profile.update_attributes(firstname: info.first_name, lastname: info.last_name, website: info.urls["Facebook"] )
      u
    when 'github'
      u = create( username: info.nickname, email: info.email)
      names = info.name.split ' '
      u.profile.update_attributes(firstname: names[0], lastname: names[1], website: info.urls["GitHub"] )
      u
    when 'identity'
      create( username: info.name, email: info.email )
    when 'google_oauth2'
      u = create( username: info.name, email: info.email)
      u.profile.update_attributes(firstname: info.first_name, lastname: info.last_name, website: hash['extra']['raw_info']['link'] )
      u
    when :open_id
      u = create( username: info.name, email: info.email)
      u.profile.update_attributes(firstname: info.first_name, lastname: info.last_name )
      u
    else
      create( username: info.name, email: info.email )
    end
  end

  def fullname
    profile.fullname || username
  end

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
  def not_classmate_with
    ids = classmates.map(&:id)
    ids << self.id
    self.class.where("users.id NOT IN (?)", ids)
  end

private
  def build_default_profile_and_schedule
    self.build_profile
    self.build_schedule
  end
end
