# frozen_string_literal: true

namespace :dev do
  desc "Pre-populate the database with data for developing"
  task prime: :environment do
    admin = Administrator.find_or_create_by(
      email: "admin@example.com",
    ) do |admin|
      admin.password = "password"
    end

    credential = Credential.find_or_create_by(
      administrator_id: admin.id,
      consumer_key: "key",
      consumer_secret: "secret",
      enabled: true,
    )

    teacher_user = User.find_or_create_by(
      lti_user_id: "1403bcc277e378cdb9aba8dc1057b6b8f5ba7514",
    ) do |user|
      user.first_name = "Demo"
      user.preferred_name = "Demo"
      user.last_name = "Teacher"
    end

    learner_user = User.find_or_create_by(
      lti_user_id: "d6807dd4a28995e894f5ac891d17f993a293c875",
    ) do |user|
      user.first_name = "Demo Learner"
      user.preferred_name = "Demo Learner"
      user.last_name = "11"
    end

    context = Context.find_or_create_by(
      lti_context_id: "b2bc1248f679be9690b070b64d9af2d91daa3380",
    ) do |context|
      context.title = "Development Starter Context"
      context.credential_id = credential.id
    end

    last_monday = Date.current.beginning_of_week - 1.week + 1.day
    resource = Resource.find_or_initialize_by(
      lti_resource_link_id: "b2dbcfdfb658e18e82fdc909b141aea47270cd3b",
    ) do |resource|
      resource.context_id = context.id
      resource.lis_outcome_service_url = "https://canvas.instructure.com/api/lti/v1/tools/293136/grade_passback",
                                         resource.starts_on = last_monday
      resource.ends_on = last_monday + 9.weeks
      resource.monday = true
    end

    if resource.save
      resource.create_meetings({ "1" => "13:00" }, "1" => "16:00")
    end

    teacher_enrollment = Enrollment.find_or_create_by(
      user_id: teacher_user.id,
    ) do |enrollment|
      enrollment.roles = "Instructor"
      enrollment.context_id = context.id
    end

    learner_enrollment = Enrollment.find_or_create_by(
      user_id: learner_user.id,
    ) do |enrollment|
      enrollment.roles = "Learner"
      enrollment.context_id = context.id
    end

    teacher_launch = Launch.create(
      enrollment_id: teacher_enrollment.id,
      credential_id: credential.id,
      payload: {
        "roles" => "Instructor",
        "action" => "create",
        "user_id" => "1403bcc277e378cdb9aba8dc1057b6b8f5ba7514",
        "ext_roles" => "urn:lti:instrole:ims/lis/Instructor,urn:lti:role:ims/lis/Instructor,urn:lti:sysrole:ims/lis/User",
        "context_id" => "b2bc1248f679be9690b070b64d9af2d91daa3380",
        "controller" => "launches",
        "lti_version" => "LTI-1p0",
        "oauth_nonce" => "W5KBESnq6C3M363irYmfGadJsx7f28stbKHrctULrQ",
        "context_label" => "firstdraft",
        "context_title" => "firstdraft Grades Demo",
        "oauth_version" => "1.0",
        "oauth_callback" => "about:blank",
        "oauth_signature" => "je0Cp0CHPubheL9UUf1liXDObuE=",
        "oauth_timestamp" => "1551808175",
        "lti_message_type" => "basic-lti-launch-request",
        "resource_link_id" => "b2dbcfdfb658e18e82fdc909b141aea47270cd3b",
        "oauth_consumer_key" => "key",
        "resource_link_title" => "Checkins Development",
        "lis_person_name_full" => "Logan Price",
        "ext_lti_assignment_id" => "ae6a9f27-1dde-43b1-92c6-4d98a296bf9e",
        "lis_person_name_given" => "Logan",
        "lis_person_name_family" => "Price",
        "oauth_signature_method" => "HMAC-SHA1",
        "lis_outcome_service_url" => "https://canvas.instructure.com/api/lti/v1/tools/293136/grade_passback",
        "launch_presentation_locale" => "en",
        "tool_consumer_info_version" => "cloud",
        "tool_consumer_instance_guid" => "07adb3e60637ff02d9ea11c7c74f1ca921699bd7.canvas.instructure.com",
        "tool_consumer_instance_name" => "Free For Teacher",
        "ext_ims_lis_basic_outcome_url" => "https://canvas.instructure.com/api/lti/v1/tools/293136/ext_grade_passback",
        "custom_canvas_assignment_title" => "Checkins Development",
        "custom_canvas_enrollment_state" => "active",
        "launch_presentation_return_url" => "https://canvas.instructure.com/courses/1176838/assignments",
        "ext_outcomes_tool_placement_url" => "https://canvas.instructure.com/api/lti/v1/turnitin/outcomes_placement/293136",
        "ext_outcome_data_values_accepted" => "url,text",
        "launch_presentation_document_target" => "iframe",
        "tool_consumer_instance_contact_email" => "notifications@instructure.com",
        "tool_consumer_info_product_family_code" => "canvas",
        "ext_outcome_result_total_score_accepted" => "true",
        "custom_canvas_assignment_points_possible" => "10",
        "ext_outcome_submission_submitted_at_accepted" => "true",
      },
    )

    learner_launch = Launch.create(
      enrollment_id: learner_enrollment.id,
      credential_id: credential.id,
      payload: {
        "roles" => "Learner",
        "action" => "create",
        "user_id" => "d6807dd4a28995e894f5ac891d17f993a293c875",
        "ext_roles" => "urn:lti:instrole:ims/lis/Student,urn:lti:role:ims/lis/Learner,urn:lti:sysrole:ims/lis/User",
        "context_id" => "b2bc1248f679be9690b070b64d9af2d91daa3380",
        "controller" => "launches",
        "lti_version" => "LTI-1p0",
        "oauth_nonce" => "XlSq1TDUYeqQ0zHlSqxXCI1JwwcgWHWB5XTCDiQ0Sk",
        "context_label" => "firstdraft",
        "context_title" => "firstdraft Grades Demo",
        "oauth_version" => "1.0",
        "oauth_callback" => "about:blank",
        "oauth_signature" => "kvtfDM01E65Fa+dA1sqYqc7cIsU=",
        "oauth_timestamp" => "1551808202",
        "lti_message_type" => "basic-lti-launch-request",
        "resource_link_id" => "b2dbcfdfb658e18e82fdc909b141aea47270cd3b",
        "oauth_consumer_key" => "key",
        "resource_link_title" => "Checkins Development",
        "lis_person_name_full" => "Demo Learner 11",
        "lis_result_sourcedid" => "293136-1176838-10869713-14273652-3418b9c6c64a6f3df674fc4dc92878a3484b78f2",
        "ext_lti_assignment_id" => "ae6a9f27-1dde-43b1-92c6-4d98a296bf9e",
        "lis_person_name_given" => "Demo Learner",
        "lis_person_name_family" => "11",
        "oauth_signature_method" => "HMAC-SHA1",
        "lis_outcome_service_url" => "https://canvas.instructure.com/api/lti/v1/tools/293136/grade_passback",
        "launch_presentation_locale" => "en",
        "tool_consumer_info_version" => "cloud",
        "tool_consumer_instance_guid" => "07adb3e60637ff02d9ea11c7c74f1ca921699bd7.canvas.instructure.com",
        "tool_consumer_instance_name" => "Free For Teacher",
        "ext_ims_lis_basic_outcome_url" => "https://canvas.instructure.com/api/lti/v1/tools/293136/ext_grade_passback",
        "custom_canvas_assignment_title" => "Checkins Development",
        "custom_canvas_enrollment_state" => "active",
        "launch_presentation_return_url" => "https://canvas.instructure.com/courses/1176838/assignments",
        "ext_outcomes_tool_placement_url" => "https://canvas.instructure.com/api/lti/v1/turnitin/outcomes_placement/293136",
        "ext_outcome_data_values_accepted" => "url,text",
        "launch_presentation_document_target" => "iframe",
        "tool_consumer_instance_contact_email" => "notifications@instructure.com",
        "tool_consumer_info_product_family_code" => "canvas",
        "ext_outcome_result_total_score_accepted" => "true",
        "custom_canvas_assignment_points_possible" => "10",
        "ext_outcome_submission_submitted_at_accepted" => "true",
      },
    )

    learner_submission = Submission.find_or_create_by(
      enrollment_id: learner_enrollment.id,
      resource_id: resource.id,
    )
    
    teacher_submission = Submission.find_or_create_by(
      enrollment_id: teacher_enrollment.id,
      resource_id: resource.id,
    )
  end
end
