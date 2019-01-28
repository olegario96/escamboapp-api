class Comment < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :description, :rating
end
