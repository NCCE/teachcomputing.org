class SupportAuditDashboard < BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::String,
    user: Field::BelongsTo,
    auditable_type: Field::String,
    affected_user: Field::BelongsTo.with_options(
      searchable: true, searchable_fields: %w[email first_name last_name]
    ),
    action: Field::String,
    audited_changes: AuditedJsonViewerField,
    comment: Field::Text,
    authoriser: Field::BelongsTo.with_options(
      searchable: true, searchable_fields: %w[first_name last_name organisation]
    ),
    ticket_id: Field::String,
    created_at: FORMATTED_DATE_TIME
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  COLLECTION_ATTRIBUTES = %i[
    user
    affected_user
    auditable_type
    action
    authoriser
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    affected_user
    auditable_type
    action
    audited_changes
    comment
    authoriser
    created_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    authoriser
    comment
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

  # Overwrite this method to customize how support_audits are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource()
  # end
end
