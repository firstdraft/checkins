# frozen_string_literal: true

module ApplicationHelper
  def link_to_show_or_back(
    object,
    show_content = "Show",
    back_content = "Back",
    options = {}
  )
    if request.path == url_for(object)
      link_to back_content, :back, options
    else
      link_to show_content, object, options
    end
  end

  def contextual_class(value)
    case value.try(:to_sym)
    when :deny, :reset, :not_accepted
      "danger"
    when :appeal, :in_appeal
      "warning"
    when :check_in, :approve, :accepted
      "success"
    else
      "secondary"
    end
  end

  def attendance_event_button(attendance, event)
    render partial: "shared/event_button",
           locals: { attendance: attendance, event: event }
  end
end
