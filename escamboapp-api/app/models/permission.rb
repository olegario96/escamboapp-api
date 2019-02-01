class Permission < ApplicationRecord
  validates_presence_of :permission

  has_and_belongs_to_many :users
end
