class SubmissionPolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def resubmit?
    submission.in?(enrollment.submissions)
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

  def submission
    record
  end
end
