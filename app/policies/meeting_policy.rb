class MeetingPolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def show?
    enrollment.teacher?
  end

  def index?
    enrollment.teacher?
  end

  def create?
    enrollment.teacher? && meeting.resource == enrollment.resource
  end

  def update?
    enrollment.teacher? && meeting.in?(enrollment.resource.meetings)
  end

  def destroy?
    enrollment.teacher? && meeting.resource == enrollment.resource
  end

  class Scope
    attr_reader :enrollment, :scope

    def initialize(enrollment, scope)
      @enrollment = enrollment
      @scope = scope
    end

    def resolve
      enrollment.context.meetings
    end
  end

  private

  def meeting
    record
  end
end
