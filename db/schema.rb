# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_29_174648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.datetime "checked_in_at"
    t.float "latitude"
    t.float "longitude"
    t.string "status", null: false
    t.bigint "meeting_id"
    t.bigint "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id", "submission_id"], name: "index_attendances_on_meeting_id_and_submission_id", unique: true
    t.index ["meeting_id"], name: "index_attendances_on_meeting_id"
    t.index ["submission_id"], name: "index_attendances_on_submission_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "present", default: true
    t.boolean "late"
    t.boolean "approved", default: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "meeting_id"
    t.bigint "submission_id"
    t.index ["meeting_id"], name: "index_check_ins_on_meeting_id"
    t.index ["submission_id"], name: "index_check_ins_on_submission_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contexts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "lti_context_id"
    t.integer "credential_id"
    t.integer "allowed_absences", default: 0
  end

  create_table "credentials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consumer_key"
    t.string "consumer_secret"
    t.integer "administrator_id"
    t.boolean "enabled", default: true
  end

  create_table "enrollments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "roles"
    t.integer "user_id"
    t.integer "context_id"
  end

  create_table "launches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "payload", default: {}
    t.integer "enrollment_id"
    t.integer "credential_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content", default: ""
  end

  create_table "resources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "meeting_schedule_hash"
    t.string "lis_outcome_service_url"
    t.string "lti_resource_link_id"
    t.integer "context_id"
    t.date "starts_on"
    t.date "ends_on"
    t.boolean "sunday", default: false
    t.boolean "monday", default: false
    t.boolean "tuesday", default: false
    t.boolean "wednesday", default: false
    t.boolean "thursday", default: false
    t.boolean "friday", default: false
    t.boolean "saturday", default: false
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "enrollment_id"
    t.bigint "resource_id"
    t.float "score", default: 0.0
    t.index ["enrollment_id"], name: "index_submissions_on_enrollment_id"
    t.index ["resource_id"], name: "index_submissions_on_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "preferred_name"
    t.string "lti_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "attendances", "meetings"
  add_foreign_key "attendances", "submissions"
  add_foreign_key "check_ins", "meetings"
  add_foreign_key "check_ins", "submissions"
  add_foreign_key "submissions", "enrollments"
  add_foreign_key "submissions", "resources"
end
