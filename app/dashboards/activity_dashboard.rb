class ActivityDashboard < BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    pathway_activities: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    title: Field::String,
    created_at: FORMATTED_DATE_TIME,
    updated_at: FORMATTED_DATE_TIME,
    credit: Field::Number,
    slug: Field::String,
    category: Field::String,
    stem_course_template_no: Field::String,
    self_certifiable: Field::Boolean,
    always_on: Field::Boolean,
    provider: Field::String,
    future_learn_course_uuid: Field::String,
    description: Field::Text,
    self_verification_info: Field::Text,
    uploadable: Field::Boolean,
    stem_activity_code: Field::String,
    remote_delivered_cpd: Field::Boolean,
    retired: Field::Boolean,
    replaced_by: Field::BelongsTo.with_options(scope: -> { Activity.courses.order(:stem_activity_code) })
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    stem_activity_code
    title
    description
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    pathway_activities
    title
    created_at
    updated_at
    slug
    category
    stem_course_template_no
    self_certifiable
    always_on
    provider
    future_learn_course_uuid
    description
    self_verification_info
    uploadable
    stem_activity_code
    remote_delivered_cpd
    retired
    replaced_by
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    pathway_activities
    title
    credit
    slug
    category
    stem_course_template_no
    self_certifiable
    provider
    future_learn_course_uuid
    description
    self_verification_info
    uploadable
    stem_activity_code
    remote_delivered_cpd
    retired
    replaced_by
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

  # Overwrite this method to customize how activities are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(activity)
    [activity.stem_activity_code, activity.title].compact.join(" - ")
  end
end
