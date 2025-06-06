class UserDashboard < BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    achievements: AchievementListField,
    assessment_attempts: Field::HasMany,
    feedback_comments: Field::HasMany,
    user_programme_enrolments: Field::HasMany,
    resource_users: Field::HasMany,
    questionnaire_response: Field::HasMany,
    id: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    email: Field::String,
    last_sign_in_at: FORMATTED_DATE_TIME,
    stem_user_id: Field::String,
    stem_achiever_contact_no: Field::String,
    stem_credentials_expires_at: FORMATTED_DATE_TIME,
    created_at: FORMATTED_DATE_TIME,
    updated_at: FORMATTED_DATE_TIME,
    teacher_reference_number: Field::String,
    stem_achiever_organisation_no: Field::String,
    future_learn_organisation_memberships: Field::Text,
    forgotten: Field::Boolean,
    audits: Field::HasMany.with_options(sort_by: "created_at", direction: "desc"),
    sent_emails: Field::HasMany.with_options(sort_by: "created_at", direction: "desc")
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    email
    first_name
    last_name
    stem_achiever_contact_no
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    email
    first_name
    last_name
    last_sign_in_at
    stem_user_id
    stem_achiever_contact_no
    future_learn_organisation_memberships
    created_at
    updated_at
    forgotten
    user_programme_enrolments
    achievements
    teacher_reference_number
    assessment_attempts
    sent_emails
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    first_name
    last_name
    email
    stem_user_id
    stem_achiever_contact_no
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    user.email.to_s
  end
end
