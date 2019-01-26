class User < ApplicationRecord
  validates_presence_of :name, :cpf, :email

  has_many :posts
end
