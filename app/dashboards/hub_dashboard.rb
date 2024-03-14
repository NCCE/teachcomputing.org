class HubDashboard < BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    hub_region: Field::BelongsTo,
    id: Field::String,
    name: Field::String,
    subdeliverer_id: Field::String,
    address: Field::String,
    postcode: Field::String,
    email: Field::String,
    phone: Field::String,
    website: Field::String,
    twitter: Field::String,
    facebook: Field::String,
    linkedin: Field::String,
    instagram: Field::String,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    created_at: FORMATTED_DATE_TIME,
    updated_at: FORMATTED_DATE_TIME
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    hub_region
    name
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    hub_region
    id
    name
    subdeliverer_id
    address
    postcode
    email
    phone
    website
    twitter
    facebook
    linkedin
    instagram
    latitude
    longitude
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    hub_region
    name
    subdeliverer_id
    address
    postcode
    email
    phone
    website
    twitter
    facebook
    linkedin
    instagram
    latitude
    longitude
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

  # Overwrite this method to customize how hubs are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(hub)
    hub.name
  end
end
