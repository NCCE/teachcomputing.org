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

ActiveRecord::Schema.define(version: 2019_04_29_110311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "achievement_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.uuid "achievement_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id", "most_recent"], name: "index_achievement_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["achievement_id", "sort_key"], name: "index_achievement_transitions_parent_sort", unique: true
  end

  create_table "achievements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.float "credit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "category"
    t.string "course_id"
    t.boolean "self_certifiable", default: false
    t.string "provider"
    t.index ["category"], name: "index_activities_on_category"
    t.index ["course_id"], name: "index_activities_on_course_id", unique: true
    t.index ["self_certifiable"], name: "index_activities_on_self_certifiable"
    t.index ["slug"], name: "index_activities_on_slug", unique: true
  end

  create_table "imports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider"
    t.string "triggered_by"
    t.datetime "completed_at"
    t.uuid "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_imports_on_activity_id"
  end

  create_table "programme_activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "programme_id", null: false
    t.uuid "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_programme_activities_on_activity_id"
    t.index ["programme_id"], name: "index_programme_activities_on_programme_id"
  end

  create_table "programmes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_programmes_on_slug", unique: true
  end

  create_table "user_programme_enrolments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "programme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programme_id"], name: "index_user_programme_enrolments_on_programme_id"
    t.index ["user_id"], name: "index_user_programme_enrolments_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "last_sign_in_at"
    t.string "stem_user_id"
    t.string "stem_achiever_contact_no"
    t.datetime "stem_credentials_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_stem_credentials_access_token"
    t.string "encrypted_stem_credentials_access_token_iv"
    t.string "encrypted_stem_credentials_refresh_token"
    t.string "encrypted_stem_credentials_refresh_token_iv"
    t.index ["stem_user_id"], name: "index_users_on_stem_user_id", unique: true
  end

  add_foreign_key "achievement_transitions", "achievements", on_delete: :cascade
end
