RSpec.describe Cms::Providers::Strapi::Queries::Components::Blocks::EnrolmentSplitCourseCard do
  it_should_behave_like "a strapi graphql component",
    %w[
      cardContent
      asideContent
      sectionTitle
      bkColor
      colorTheme
      asideTitle
      asideIcon
      enrolAside
      programme
    ]
end
