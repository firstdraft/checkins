# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[5.2]
  def up
    create_table :submissions do |t|
      t.references :enrollment, foreign_key: true
      t.references :resource, foreign_key: true
      t.float      :score
    end

    add_reference :check_ins, :submission, foreign_key: true

    Enrollment.find_each do |enrollment|
      resource = Resource.find_by(
        lti_resource_link_id: enrollment.launches.last.payload['resource_link_id']
      )

      sub = Submission.create(
        enrollment_id: enrollment.id,
        resource_id: resource.id,
        score: enrollment.score
      )

      enrollment.check_ins.each do |check_in|
        check_in.update(submission_id: sub.id)
      end
    end
    remove_column :check_ins, :enrollment_id
    remove_column :enrollments, :score
  end

  def down
    add_column :enrollments, :score, :float
    add_column :check_ins, :enrollment_id, :integer

    Enrollment.find_each do |enrollment|
      resource = Resource.find_by(
        lti_resource_link_id: enrollment.launches.last.payload['resource_link_id']
      )
      sub = Submission.find_by(
        enrollment_id: enrollment.id,
        resource_id: resource.id
      )
      enrollment.update(score: sub.score)

      CheckIn.where(submission_id: sub.id).each do |check_in|
        check_in.update(enrollment_id: enrollment.id)
      end
    end

    remove_reference :check_ins, :submission
    drop_table :submissions
  end
end
