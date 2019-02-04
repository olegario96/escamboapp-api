class Post < ApplicationRecord
  # MoneyRails
  monetize :price_cents

  belongs_to :category, optional: false
  belongs_to :user, optional: false
  has_many :comments, dependent: :destroy
  # Images for post
  has_many_attached :images

  validates_presence_of :productName, :description, :price_cents

  def with_images
    images_ = []
    images.each { |image| images_.push(image.service_url) }
    self.attributes.merge(images: images_)
  end

  private

  def formatted_price
    return "#{price.currency.symbol}#{price.fractional.to_f/100}"
  end
end
