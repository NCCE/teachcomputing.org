require 'administrate/base_dashboard'

class UserProgrammeEnrolmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    programme: Field::BelongsTo,
    pathway: Field::BelongsTo,
    state_machine: StatePickerField,
    id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    flagged: Field::Boolean,
    auto_enrolled: Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    programme
    pathway
    state_machine
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    programme
    pathway
    created_at
    updated_at
    flagged
    auto_enrolled
    state_machine
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    state_machine
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

  # Overwrite this method to customize how user programme enrolments are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(upe)
    p = Programme.find_by(id: upe.programme_id)
    title = p&.title || 'Unknown programme'
    "#{title} (#{upe.current_state})"
  end
end
