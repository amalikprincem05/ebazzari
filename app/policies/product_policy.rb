class ProductPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || record.shop.user == user)
  end

  def update?
    user.present? && (user.admin? || record.shop.user == user)
  end

  def destroy?
    update?
  end

  def show?
    record.shop.approved? || user&.admin? || record.shop.user == user
  end
end
