class AttendancePolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def appeal
    !enrollment.teacher?
  end

  def approve
    enrollment.teacher?
  end

  def check_in
    !enrollment.teacher?
  end

  def deny
    enrollment.teacher?
  end

  def reset
    enrollment.teacher?
  end

  class Scope
    attr_reader :enrollment, :scope

    def initialize(enrollment, scope)
      @enrollment = enrollment
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private

  def attendance
    record
  end
end
