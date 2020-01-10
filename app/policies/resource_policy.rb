class ResourcePolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def show_meetings?
    enrollment.teacher? && enrollment.in?(resource.enrollments)
  end

  def index?
    true
  end

  def show?
    if enrollment.teacher?
      enrollment.context == resource.context
    else
      resource == enrollment.resource
    end
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    enrollment.teacher? && enrollment.context == resource.context
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
      enrollment.context.resources
    end
  end

  private

  def resource
    record
  end
end
