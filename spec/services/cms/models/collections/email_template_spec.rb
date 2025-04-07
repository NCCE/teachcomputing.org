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
      activity_state: :active
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

  context "time_diff_words" do
    it "should return months" do
      expect(@model.time_diff_words(3.months.ago)).to eq("3 months")
    end

    it "should return month when only one" do
      expect(@model.time_diff_words(1.months.ago)).to eq("1 month")
    end

    it "should return year when over 12 months" do
      expect(@model.time_diff_words(12.months.ago)).to eq("1 year")
    end

    it "should return years when over 24 months" do
      expect(@model.time_diff_words(25.months.ago)).to eq("2 years")
    end
  end
end
