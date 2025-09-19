class Shop < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_one_attached :logo

  validates :name, presence: true
  validates :user, presence: true

  scope :approved, -> { where(approved: true) }
  scope :pending,  -> { where(approved: false) }

  # optional slug for pretty URLs
  before_create :generate_slug

  def generate_slug
    base = name.parameterize
    count = Shop.where("slug LIKE ?", "#{base}%").count
    self.slug = count.zero? ? base : "#{base}-#{count+1}"
  end
end
