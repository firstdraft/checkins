desc "Update score for all submissions of currently active resources"
task update_active_submissions: :environment do
  active_resources = Resource.where("ends_on >= ?", Date.today).where("starts_on <= ?", Date.today)

  active_resources.each do |resource|
    resource.submissions.each(&:update_score)
  end
end
