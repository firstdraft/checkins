class ChangeContextForeignKeyToResourceInEnrollment < ActiveRecord::Migration[5.2]
  def up
    add_reference :enrollments, :resource, foreign_key: true

    Enrollment.find_each do |enrollment|
      launch = enrollment.launches.first
      resource_link_id = launch.payload["resource_link_id"]
      resource = Resource.find_by(lti_resource_link_id: resource_link_id)

      enrollment.update(resource_id: resource.id)
    end

    remove_column :enrollments, :context_id
  end

  def down
    add_reference :enrollments, :context, foreign_key: true

    Enrollment.find_each do |enrollment|
      launch = enrollment.launches.first
      context_id = launch.payload["context_id"]
      context = Context.find_by(lti_context_id: context_id)

      enrollment.update(context_id: context.id)
    end

    remove_column :enrollments, :resource_id
  end
end
