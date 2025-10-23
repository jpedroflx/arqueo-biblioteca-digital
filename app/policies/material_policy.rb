class MaterialPolicy < ApplicationPolicy
  def index?  = true
  def show?   = true
  def create? = user.present?
  def update? = user.present?
  def destroy? = user.present?

  class Scope < Scope
    def resolve = scope.all
  end
end
