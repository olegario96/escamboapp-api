class Post < ApplicationRecord
  belongs_to :category, optional: false
  belongs_to :user, optional: false

  validates_presence_of :productName, :description
end
