# frozen_string_literal: true

desc "One-time task to calculate and record an enrollment's score"
task record_scores_for_enrollments: :environment do
  Enrollment.find_each do |enrollment|
    enrollment.update(score: enrollment.grade_attendance)
  end
end
