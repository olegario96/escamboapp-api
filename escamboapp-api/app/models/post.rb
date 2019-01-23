class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates_presence_of :productName, :description
end
