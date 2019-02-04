class Post < ApplicationRecord
  belongs_to :category, optional: false
  belongs_to :user, optional: false
  has_many :comments, dependent: :destroy

  # MoneyRails
  monetize :price_cents

  validates_presence_of :productName, :description, :price_cents
end
