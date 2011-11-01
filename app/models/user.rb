class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy
  has_one :schedule

  def self.create_from_hash!(hash)
    create( name: hash['info']['name'], email: hash['info']['email'] )
  end
end
