class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  scope :admin, -> {where(is_admin: true)}

  #
  # vanity users
  #
  def self.kyle
    User.find_by(email: 'kyle.p.fritz@gmail.com')
  end
end
