require "rails_helper"

RSpec.describe Cms::Models::Collections::EmailTemplate do
  let(:slug) { "test-email-slug" }
  let(:subject) { "Test Email" }
  let(:user) { create(:user, first_name: "Frodo") }
  let(:user2) { create(:user, first_name: "Gandalf") }
  let(:text_content) {
    [
      {
        type: "paragraph",
        children: [
          {text: "Hello {first_name}", type: "text"}
        ]
      },
      {
        type: "paragraph",
        children: [
          {
            text: "You,",
            type: "text"
          },
          {
            url: "https://www.google.com",
            type: "link",
            children: [
              {
                text: "{first_name} should click this link",
                type: "text"
              }
            ]
          },
          {
            text: ".",
            type: "text"
          }
        ]
      },
      {
        type: "paragraph",
        children: [
          {
            text: "You completed {last_cpd_title} {last_cpd_completed_ago} ago.",
            type: "text"
          }
        ]
      }
    ]
  }

  before do
    @model = described_class.new(
      slug:,
      subject:,
      email_content: Cms::Mocks::EmailComponents::Text.generate_raw_data(text_content:),
      programme_slug: "primary-certificate",
      completed_programme_activity_group_slugs: [],
      activity_state: :active,
      enrolled: true
    )
  end

  it "should replace first_name with user name" do
    content = @model.process_blocks(text_content, user)
    text = content.dig(0, :children, 0, :text)
    expect(text).to eq("Hello Frodo")

    content = @model.process_blocks(text_content, user2)
    text = content.dig(0, :children, 0, :text)
    expect(text).to eq("Hello Gandalf")
  end

  it "should replace first_name in deeper text" do
    content = @model.process_blocks(text_content, user)
    text = content.dig(1, :children, 1, :children, 0, :text)
    expect(text).to eq("Frodo should click this link")
  end

  context "with achievement" do
    let(:activity) { create(:activity, title: "Past activity") }
    let!(:achievement) { create(:completed_achievement, activity:, user:) }
    let(:updated_at) { DateTime.parse("2025-04-01") }

    before do
      allow(achievement).to receive(:updated_at).and_return(updated_at)
      allow(user).to receive(:sorted_completed_cpd_achievements_by).and_return([achievement])

      travel_to DateTime.parse("2025-05-01")
    end

    after do
      travel_back
    end

    it "should replace achievement placeholders using time_ago_in_words" do
      content = @model.process_blocks(text_content, user)
      text = content.dig(2, :children, 0, :text)
      expect(text).to eq("You completed Past activity about 1 month ago.")
    end
  end

  it "passing nil into completed_programme_activity_group_slugs defaults to array" do
    @model = described_class.new(
      slug:,
      subject:,
      email_content: Cms::Mocks::EmailComponents::Text.generate_raw_data(text_content:),
      programme_slug: "primary-certificate",
      completed_programme_activity_group_slugs: nil,
      activity_state: :active,
      enrolled: true
    )

    expect(@model.completed_programme_activity_groups).to eq([])
  end
end
