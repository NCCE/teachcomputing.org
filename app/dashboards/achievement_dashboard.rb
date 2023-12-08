require 'administrate/base_dashboard'

class AchievementDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    activity: Field::BelongsTo,
    user: Field::BelongsTo,
    programmes: Field::HasMany,
    supporting_evidence_attachment: Field::HasOne,
    supporting_evidence_blob: Field::HasOne,
    current_state: Field::String.with_options(searchable: false),
    id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
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
    programmes
    current_state
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    activity
    programmes
    supporting_evidence_attachment
    supporting_evidence_blob
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
    programme
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
    title = a&.title || 'Unknown activity'
    "#{title} (#{achievement.current_state})"
  end
end
