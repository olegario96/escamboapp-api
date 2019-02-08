class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_presence_of :title, :description, :rating, :post_id, :user_id
end
