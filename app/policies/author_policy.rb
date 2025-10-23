class AuthorPolicy < ApplicationPolicy
  def index?  = user.present?
  def show?   = user.present?
  def create? = user.present?
  def update? = user.present?
  def destroy? = user.present?

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end

