class MeetingPolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def show?
    meeting.resource.in?(enrollment.resources)
  end

  def create?
    teacher_for_meeting?
  end

  def update?
    teacher_for_meeting?
  end

  def destroy?
    teacher_for_meeting?
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

  def teacher_for_meeting?
    enrollment.teacher? && meeting.resource.in?(enrollment.resources)
  end
end
