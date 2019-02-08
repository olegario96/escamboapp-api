class User < ApplicationRecord
  # Encrypt password
  has_secure_password

  # enable image for user
  has_one_attached :avatar, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :permissions

  validates_presence_of :name, :cpf, :email, :password_digest

  def with_avatar
    if avatar.attached?
      attributes.merge({avatar: avatar.service_url})
    else
      attributes
    end
  end
end
