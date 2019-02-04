class User < ApplicationRecord
  # Encrypt password
  has_secure_password

  # enable image for user
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :permissions

  validates_presence_of :name, :cpf, :email, :password_digest

  def with_avatar
    self.attributes.merge({avatar: avatar.service_url})
  end
end
