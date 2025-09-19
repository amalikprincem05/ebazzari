class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, owner: 1, admin: 2 }

  has_many :shops, dependent: :destroy

  # Only shop owners can create shops — enforcement via Pundit/controller
  # Optional: validation that owner accounts must be approved by admin
  validates :role, presence: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :customer
    self.approved = false if self.approved.nil?
  end
end


