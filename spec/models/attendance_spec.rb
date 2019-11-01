# == Schema Information
#
# Table name: attendances
#
#  id            :bigint(8)        not null, primary key
#  checked_in_at :datetime
#  latitude      :float
#  longitude     :float
#  status        :string           not null
#  meeting_id    :bigint(8)
#  submission_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (submission_id => submissions.id)
#

require "rails_helper"

RSpec.describe Attendance, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
