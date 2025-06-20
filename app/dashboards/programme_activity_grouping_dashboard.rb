require "administrate/base_dashboard"
require "administrate/field/jsonb"

class ProgrammeActivityGroupingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::String,
    activities: Field::HasMany,
    community: Field::Boolean,
    programme: Field::BelongsTo,
    programme_activities: Field::HasMany,
    progress_bar_title: Field::String,
    required_for_completion: Field::Number,
    sort_key: Field::Number,
    title: Field::String,
    web_copy: ProgrammeActivityGroupingJsonViewerField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    title
    programme
    activities
    community
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    title
    progress_bar_title
    programme
    community
    web_copy
    programme_activities
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    title
    activities
    community
    programme
    programme_activities
    progress_bar_title
    required_for_completion
    web_copy
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

  # Overwrite this method to customize how programme activity groupings are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(programme_activity_grouping)
    programme_activity_grouping.title.to_s
  end
end
