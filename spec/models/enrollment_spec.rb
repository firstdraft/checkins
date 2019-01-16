
# == Schema Information
#
# Table name: enrollments
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  roles       :string
#  user_id     :integer
#  resource_id :bigint(8)
#
# Foreign Keys
#
#  fk_rails_...  (resource_id => resources.id)
#
