class ContextPolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def show?
    enrollment.teacher? && context == enrollment.context
  end

  def update?
    enrollment.teacher? && context == enrollment.context
  end

  def edit?
    update?
  end

  def destroy?
    enrollment.teacher? && context == enrollment.context
  end

  class Scope
    attr_reader :enrollment, :scope

    def initialize(enrollment, scope)
      @enrollment = enrollment
      @scope = scope
    end

    def resolve
      enrollment.contexts
    end
  end

  private

  def context
    record
  end
end
