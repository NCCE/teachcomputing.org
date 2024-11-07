require "rails_helper"

RSpec.describe Cms::Models::EmailTemplate do
  let(:slug) { "test-email-slug" }
  let(:subject) { "Test Email" }
  let(:user) { create(:user, first_name: "Frodo") }
  let(:user2) { create(:user, first_name: "Gandalf") }
  let(:email_content) {
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
      email_content: [
        {
          __component: "email-content.text",
          textContent: email_content
        }
      ],
      programme_slug: "primary-certificate"
    )
  end

  it "should replace first_name with user name" do
    content = @model.process_blocks(email_content, user)
    text = content.dig(0, :children, 0, :text)
    expect(text).to eq("Hello Frodo")

    content = @model.process_blocks(email_content, user2)
    text = content.dig(0, :children, 0, :text)
    expect(text).to eq("Hello Gandalf")
  end

  it "should replace first_name in deeper text" do
    content = @model.process_blocks(email_content, user)
    text = content.dig(1, :children, 1, :children, 0, :text)
    expect(text).to eq("Frodo should click this link")
  end
end
