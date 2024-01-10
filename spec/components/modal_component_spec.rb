require "rails_helper"

RSpec.describe ModalComponent, type: :component do
  let(:expanded) { false }
  let(:title) { 'I\m a title!' }
  let(:reopen_button_text) { nil }
  let(:body) { nil }
  let(:close_button) { nil }

  before do
    render_inline(described_class.new(expanded:, title:, reopen_button_text:)) do |component|
      component.with_body { body.html_safe } if body.present?
      component.with_close_button { close_button.html_safe } if close_button.present?
    end
  end

  it "doesn't have class ncce-modal--expanded" do
    expect(page).to have_no_css(".ncce-modal--expanded")
  end

  it "doesn't have a reopen button" do
    expect(page).to have_no_css(".ncce-modal--reopen")
  end

  context "when the reopen button text is present" do
    let(:reopen_button_text) { "Reopen me!" }

    it "should render reopen button" do
      expect(page).to have_css(".ncce-modal--reopen", text: "Reopen me!")
    end
  end

  context "when expanded is set to true" do
    let(:expanded) { true }

    it "should have class ncce-modal--expanded" do
      expect(page).to have_css(".ncce-modal--expanded")
    end

    it "should have default close button" do
      expect(page).to have_css(".icon-close")
    end

    context "when a replacement close button is provided" do
      let(:close_button) { '<div class="replacement-icon"></div>' }

      it "should have replacement button" do
        expect(page).to have_css(".replacement-icon")
        expect(page).to have_no_css(".icon-close")
      end
    end

    context "when a body is provided" do
      let(:body) { '<div class="library">There\'s a body in the library!</div>' }

      it "should have a body" do
        expect(page).to have_css(".library", text: "There's a body in the library!")
      end
    end
  end

  context "when a replacement close button is provided" do
    let(:close_button) { '<div class="replacement-icon"></div>' }

    it "should have replacement button" do
      expect(page).to have_css(".replacement-icon")
      expect(page).to have_no_css(".icon-close")
    end
  end

  context "when a body is provided" do
    let(:body) { '<div class="library">There\'s a body in the library!</div>' }

    it "should have a body" do
      expect(page).to have_css(".library", text: "There's a body in the library!")
    end
  end
end
