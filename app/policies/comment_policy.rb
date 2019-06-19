class CommentPolicy < ApplicationPolicy
  attr_reader :enrollment, :record

  def initialize(enrollment, record)
    @enrollment = enrollment
    @record = record
  end

  def create?
    if enrollment.teacher?
      comment.commentable.context == enrollment.context
    else
      comment.commentable.in?(enrollment.attendances)
    end
  end

  class Scope
    attr_reader :enrollment, :scope

    def initialize(enrollment, scope)
      @enrollment = enrollment
      @scope = scope
    end

    def resolve
      enrollment.resources
    end
  end

  private

  def comment
    record
  end
end
