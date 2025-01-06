require "rails_helper"

RSpec.describe Cms::EmailComponents::BaseComponent do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:email_template) {
    Cms::Models::EmailTemplate.new(
      slug: "test",
      subject: "Test email",
      email_content: Cms::Mocks::RichBlocks.generate_data,
      programme_slug: programme.slug,
      completed_programme_activity_group_slugs: [],
      activity_state: :active
    )
  }

  context "instance" do
    before do
      @instance = described_class.new
    end

    describe "#render?" do
      it "should return true for render" do
        expect(@instance.render?(email_template, user)).to be true
      end
    end

    describe "#render" do
      it "should raise NotImplementedError" do
        expect { @instance.render(email_template, user) }.to raise_error(NotImplementedError)
      end
    end

    describe "#render_text" do
      it "should raise NotImplementedError" do
        expect { @instance.render_text(email_template, user) }.to raise_error(NotImplementedError)
      end
    end
  end
end
