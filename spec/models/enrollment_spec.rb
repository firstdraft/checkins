# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  roles      :string
#  user_id    :integer
#  context_id :integer
#  score      :float
#
