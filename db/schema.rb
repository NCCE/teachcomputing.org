# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_12_090704) do

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
    t.integer "progress", default: 0, null: false
    t.text "self_verification_info"
    t.index ["activity_id", "user_id"], name: "index_achievements_on_activity_id_and_user_id", unique: true
  end

  create_table "achiever_sync_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "state", null: false
    t.uuid "user_programme_enrolment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_programme_enrolment_id"], name: "index_achiever_sync_records_on_user_programme_enrolment_id"
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.float "credit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "category"
    t.string "stem_course_template_no"
    t.boolean "self_certifiable", default: false
    t.string "provider"
    t.string "future_learn_course_uuid"
    t.text "description"
    t.text "self_verification_info"
    t.boolean "uploadable", default: false
    t.string "stem_activity_code"
    t.boolean "remote_delivered_cpd", default: false
    t.boolean "always_on", default: false
    t.string "booking_programme_slug"
    t.boolean "retired", default: false
    t.boolean "coming_soon", default: false
    t.jsonb "public_copy"
    t.index ["category"], name: "index_activities_on_category"
    t.index ["future_learn_course_uuid"], name: "index_activities_on_future_learn_course_uuid", unique: true
    t.index ["self_certifiable"], name: "index_activities_on_self_certifiable"
    t.index ["stem_course_template_no"], name: "index_activities_on_stem_course_template_no", unique: true
  end

  create_table "aggregate_downloads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "uri"
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uri"], name: "index_aggregate_downloads_on_uri"
  end

  create_table "assessment_attempt_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.uuid "assessment_attempt_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_attempt_id", "most_recent"], name: "index_assessment_attempt_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["assessment_attempt_id", "sort_key"], name: "index_assessment_attempt_transitions_parent_sort", unique: true
  end

  create_table "assessment_attempts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "assessment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted_conditions"
    t.index ["assessment_id"], name: "index_assessment_attempts_on_assessment_id"
    t.index ["user_id"], name: "index_assessment_attempts_on_user_id"
  end

  create_table "assessments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "link"
    t.uuid "programme_id", null: false
    t.uuid "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "class_marker_test_id"
    t.float "required_pass_percentage", default: 65.0, null: false
    t.index ["activity_id"], name: "index_assessments_on_activity_id"
    t.index ["programme_id"], name: "index_assessments_on_programme_id"
  end

  create_table "audits", force: :cascade do |t|
    t.uuid "auditable_id"
    t.string "auditable_type"
    t.uuid "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.uuid "ticket_id"
    t.uuid "authoriser_id"
    t.uuid "affected_user_id"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["authoriser_id"], name: "index_audits_on_authoriser_id"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "authorisers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "organisation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "badges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "programme_id", null: false
    t.boolean "active", default: false
    t.string "academic_year", null: false
    t.uuid "credly_badge_template_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["programme_id"], name: "index_badges_on_programme_id"
  end

  create_table "downloads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "aggregate_download_id"
    t.string "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aggregate_download_id"], name: "index_downloads_on_aggregate_download_id"
    t.index ["user_id"], name: "index_downloads_on_user_id"
  end

  create_table "enrichment_entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "enrichment_grouping_id"
    t.string "title"
    t.string "title_url"
    t.string "image_url"
    t.string "body"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "i_belong"
    t.integer "order"
    t.index ["enrichment_grouping_id"], name: "index_enrichment_entries_on_enrichment_grouping_id"
  end

  create_table "enrichment_groupings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "programme_id"
    t.string "type"
    t.string "title"
    t.datetime "term_start"
    t.datetime "term_end"
    t.boolean "published"
    t.boolean "coming_soon", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["programme_id"], name: "index_enrichment_groupings_on_programme_id"
  end

  create_table "feedback_comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "area"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_feedback_comments_on_user_id"
  end

  create_table "hub_regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order"], name: "index_hub_regions_on_order", unique: true
  end

  create_table "hubs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "hub_region_id", null: false
    t.uuid "subdeliverer_id", null: false
    t.string "address"
    t.string "postcode"
    t.string "email"
    t.string "phone"
    t.string "website"
    t.string "twitter"
    t.string "facebook"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "satellite", default: false
    t.string "satellite_info"
    t.string "linkedin"
    t.index ["hub_region_id"], name: "index_hubs_on_hub_region_id"
    t.index ["latitude", "longitude"], name: "index_hubs_on_latitude_and_longitude"
  end

  create_table "pathway_activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "pathway_id", null: false
    t.uuid "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "supplementary", default: false
    t.index ["activity_id"], name: "index_pathway_activities_on_activity_id"
    t.index ["pathway_id"], name: "index_pathway_activities_on_pathway_id"
  end

  create_table "pathways", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.int4range "range", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", null: false
    t.string "pdf_link"
    t.uuid "programme_id", null: false
    t.integer "order"
    t.jsonb "web_copy"
    t.boolean "legacy", default: false, null: false
    t.index ["programme_id"], name: "index_pathways_on_programme_id"
    t.index ["slug"], name: "index_pathways_on_slug", unique: true
  end

  create_table "programme_activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "programme_id", null: false
    t.uuid "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "programme_activity_grouping_id"
    t.integer "order"
    t.boolean "legacy", default: false, null: false
    t.index ["activity_id"], name: "index_programme_activities_on_activity_id"
    t.index ["programme_id"], name: "index_programme_activities_on_programme_id"
  end

  create_table "programme_activity_groupings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.integer "sort_key"
    t.integer "required_for_completion"
    t.uuid "programme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "progress_bar_title"
    t.boolean "community", default: false
    t.jsonb "web_copy"
    t.jsonb "metadata"
    t.string "type"
    t.index ["programme_id"], name: "index_programme_activity_groupings_on_programme_id"
  end

  create_table "programme_complete_counters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "programme_id", null: false
    t.integer "counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programme_id"], name: "index_programme_complete_counters_on_programme_id"
  end

  create_table "programmes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enrollable", default: false
    t.string "type"
    t.index ["slug"], name: "index_programmes_on_slug", unique: true
  end

  create_table "questionnaire_response_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.uuid "questionnaire_response_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_response_id", "most_recent"], name: "index_questionnaire_response_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["questionnaire_response_id", "sort_key"], name: "index_questionnaire_response_transitions_parent_sort", unique: true
  end

  create_table "questionnaire_responses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "questionnaire_id", null: false
    t.uuid "user_id", null: false
    t.integer "current_question", default: 1
    t.json "answers", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_questionnaire_responses_on_questionnaire_id"
    t.index ["user_id", "questionnaire_id"], name: "index_one_questionnaire_per_user", unique: true
    t.index ["user_id"], name: "index_questionnaire_responses_on_user_id"
  end

  create_table "questionnaires", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "programme_id", null: false
    t.string "title"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programme_id"], name: "index_questionnaires_on_programme_id"
    t.index ["slug"], name: "index_questionnaires_on_slug", unique: true
  end

  create_table "resource_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.integer "resource_year", null: false
    t.integer "counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "resource_year"], name: "resource_year_user", unique: true
    t.index ["user_id"], name: "index_resource_users_on_user_id"
  end

  create_table "searchable_pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.string "title", null: false
    t.text "excerpt", null: false
    t.datetime "published_at"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sent_emails", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "mailer_type", null: false
    t.string "subject", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "mailer_type"], name: "index_one_mailer_type_per_user", unique: true
    t.index ["user_id"], name: "index_sent_emails_on_user_id"
  end

  create_table "user_programme_enrolment_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.uuid "user_programme_enrolment_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_programme_enrolment_id", "most_recent"], name: "index_user_programme_enrolment_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["user_programme_enrolment_id", "sort_key"], name: "index_user_programme_enrolment_transitions_parent_sort", unique: true
  end

  create_table "user_programme_enrolments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "programme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "flagged", default: false
    t.boolean "auto_enrolled", default: false
    t.uuid "pathway_id"
    t.uuid "completed_pathway_id"
    t.jsonb "message_flags"
    t.jsonb "complete_certificate_metadata", default: {}
    t.index ["pathway_id"], name: "index_user_programme_enrolments_on_pathway_id"
    t.index ["programme_id", "user_id"], name: "unique_programme_per_user", unique: true
    t.index ["programme_id"], name: "index_user_programme_enrolments_on_programme_id"
    t.index ["user_id"], name: "index_user_programme_enrolments_on_user_id"
  end

  create_table "user_report_entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "programme_slug", null: false
    t.string "user_email", null: false
    t.string "user_stem_user_id", null: false
    t.boolean "user_enrolled", default: false, null: false
    t.datetime "enrolled_at"
    t.datetime "last_active_at"
    t.boolean "completed_cpd_component", default: false, null: false
    t.boolean "completed_certificate", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pending_certificate", default: false, null: false
    t.boolean "completed_first_community_component", default: false, null: false
    t.boolean "completed_second_community_component", default: false, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "last_sign_in_at"
    t.string "stem_user_id"
    t.uuid "stem_achiever_contact_no"
    t.datetime "stem_credentials_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_stem_credentials_access_token"
    t.string "encrypted_stem_credentials_access_token_iv"
    t.string "encrypted_stem_credentials_refresh_token"
    t.string "encrypted_stem_credentials_refresh_token_iv"
    t.string "teacher_reference_number"
    t.string "stem_achiever_organisation_no"
    t.text "future_learn_organisation_memberships", default: [], array: true
    t.boolean "forgotten", default: false
    t.string "school_name"
    t.index ["stem_user_id"], name: "index_users_on_stem_user_id", unique: true
    t.index ["teacher_reference_number"], name: "index_users_on_teacher_reference_number", unique: true
  end

  add_foreign_key "achievement_transitions", "achievements", on_delete: :cascade
  add_foreign_key "achiever_sync_records", "user_programme_enrolments"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assessment_attempt_transitions", "assessment_attempts"
  add_foreign_key "badges", "programmes"
  add_foreign_key "downloads", "aggregate_downloads"
  add_foreign_key "enrichment_entries", "enrichment_groupings"
  add_foreign_key "enrichment_groupings", "programmes"
  add_foreign_key "feedback_comments", "users"
  add_foreign_key "hubs", "hub_regions"
  add_foreign_key "pathway_activities", "activities"
  add_foreign_key "pathway_activities", "pathways"
  add_foreign_key "questionnaire_response_transitions", "questionnaire_responses"
  add_foreign_key "user_programme_enrolment_transitions", "user_programme_enrolments"
  add_foreign_key "user_programme_enrolments", "pathways"
end
