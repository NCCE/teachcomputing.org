class AchievementDashboard < BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    activity: Field::BelongsTo,
    user: Field::BelongsTo,
    supporting_evidence_attachment: Field::HasOne,
    supporting_evidence_blob: Field::HasOne,
    self_verification_info: Field::String,
    current_state: Field::String.with_options(searchable: false),
    id: Field::String,
    created_at: FORMATTED_DATE_TIME,
    updated_at: FORMATTED_DATE_TIME,
    progress: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    activity
    current_state
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    activity
    supporting_evidence_attachment
    supporting_evidence_blob
    self_verification_info
    id
    created_at
    updated_at
    progress
    current_state
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    activity
    user
    supporting_evidence_attachment
    supporting_evidence_blob
    progress
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

  # Overwrite this method to customize how achievements are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(achievement)
    a = Activity.find_by(id: achievement.activity_id)
    title = a&.title || "Unknown activity"
    "#{title} (#{achievement.current_state})"
  end
end
