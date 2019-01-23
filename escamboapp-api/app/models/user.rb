class User < ApplicationRecord
  validates_presence_of :name, :cpf, :email
end
