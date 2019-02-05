# frozen_string_literal: true

# == Schema Information
#
# Table name: resources
#
#  id                      :bigint(8)        not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  meeting_schedule_hash   :string
#  lis_outcome_service_url :string
#  lti_resource_link_id    :string
#  context_id              :integer
#  starts_on               :date
#  ends_on                 :date
#  sunday                  :boolean          default(FALSE)
#  monday                  :boolean          default(FALSE)
#  tuesday                 :boolean          default(FALSE)
#  wednesday               :boolean          default(FALSE)
#  thursday                :boolean          default(FALSE)
#  friday                  :boolean          default(FALSE)
#  saturday                :boolean          default(FALSE)
#

class Resource < ApplicationRecord
  # after_update :create_meetings

  belongs_to :context
  has_many :submissions, dependent: :destroy
  has_many :enrollments, through: :submissions
  has_many :meetings, dependent: :destroy
  has_many :check_ins, through: :meetings

  validate :must_have_schedule, on: :update
  validate :starts_on_earlier_than_ends_on, on: :update

  def must_have_schedule
    if starts_on.blank? || ends_on.blank?
      errors.add(:base, 'You have to provide a schedule')
    end
  end

  def starts_on_earlier_than_ends_on
    if starts_on && ends_on && starts_on > ends_on
      errors.add(:base, 'Start date must be earlier than end date')
    end
  end

  def meets_today?
    # returns true or false
  end

  def days_of_week_hash
    hash = {
      sunday: sunday,
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday
    }
  end

  def days_of_week_array
    array = []
    days_of_week_hash.each_with_index do |(_key, value), index|
      array << index if value
    end
    array
  end

  def all_occurrences
    # returns an array of Date
    date_range = (starts_on..ends_on).to_a
    occurrences = []

    date_range.each do |date|
      occurrences << date if date.wday.in?(days_of_week_array)
    end
    occurrences
  end

  def create_meetings(start_times_hash, end_times_hash)
    # start_times_hash and end_times_hash look like {"0" => "13:00", "2" => "14:30", "4" => "08:00"}
    Chronic.time_class = Time.zone
    unless meetings.any?
      all_occurrences.each do |date|
        m = meetings.new(
          start_time: Chronic.parse(date.to_s + ' ' + start_times_hash[date.wday.to_s]).utc,
          end_time: Chronic.parse(date.to_s + ' ' + end_times_hash[date.wday.to_s]).utc
        )
        m.save
      end
    end
  end

  def meetings_by_week
    hash = {}
    meetings.order(:start_time).each do |m|
      week_start = m.start_time.beginning_of_week
      hash[week_start] = [] if hash[week_start].nil?
      hash[week_start] << m
    end
    # changes key from first Date of week to week number of resource
    hash.keys.each_with_index do |key, index|
      hash[index + 1] = hash.delete(key)
    end
    hash
  end

  def nearest_meeting
    meetings.min_by { |meeting| (meeting.start_time - Time.now).abs }
  end
end
