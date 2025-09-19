class Product < ApplicationRecord
  belongs_to :shop
  has_many_attached :images

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where("stock > 0") }
end
