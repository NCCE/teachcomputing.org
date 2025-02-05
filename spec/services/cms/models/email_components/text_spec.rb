require "rails_helper"

RSpec.describe Cms::Models::EmailComponents::Text do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:email_template) {
    Cms::Models::Collections::EmailTemplate.new(
      slug: "test",
      subject: "Test email",
      email_content: Cms::Mocks::Text::RichBlocks.generate_data,
      programme_slug: programme.slug,
      completed_programme_activity_group_slugs: [],
      activity_state: :active,
      enrolled: true
    )
  }

  before do
    @email_text = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::EmailComponents::Text.generate_raw_data)
  end

  it "should render as CmsRichTextBlockComponent" do
    expect(@email_text.render(email_template, user)).to be_a(Cms::RichTextBlockComponent)
  end

  it "should render text as Cms::RichTextBlockTextComponent" do
    expect(@email_text.render_text(email_template, user)).to be_a(Cms::RichTextBlockTextComponent)
  end
end
