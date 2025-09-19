class ShopPolicy < ApplicationPolicy
  def show?
    record.approved? || user&.admin? || record.user == user
  end

  def create?
    user.present? && (user.owner? || user.admin?)
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

  def destroy?
    update?
  end
end
