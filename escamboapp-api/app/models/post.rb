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
    if not self.images.empty?
      images_ = []
      images.each { |image| images_.push(image.service_url) }
      self.attributes.merge(images: images_)
    else
      self.attributes
    end
  end

  def self.search(term)
    Post.all.where('lower(productName) LIKE ?', "%#{term.downcase}")
  end

  private

  def formatted_price
    "#{price.currency.symbol}#{price.fractional.to_f/100}"
  end
end
