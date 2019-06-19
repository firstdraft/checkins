class UserPolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def show?
    user == enrollment.user
  end

  def update?
    user == enrollment.user
  end

  def edit?
    update?
  end

  def destroy?
    enrollment.teacher? && enrollment.context == resource.context
  end

  class Scope
    attr_reader :enrollment, :scope

    def initialize(enrollment, scope)
      @enrollment = enrollment
      @scope = scope
    end

    def resolve
      # scope.all
      enrollment.resources
    end
  end

  private

  def user
    record
  end
end
