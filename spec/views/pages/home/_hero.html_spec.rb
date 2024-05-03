require "rails_helper"

RSpec.describe("pages/home/_hero", type: :view) do
  let(:user) { create(:user) }
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_text "Helping you teach computing"
  end

  it "has button to register" do
    expect(rendered).to have_link("Join for free", href: auth_url)
  end

  it "has button to find out more about NCCE" do
    expect(rendered).to have_link("Learn more about us", href: about_path)
  end

  context "when a user is signed in" do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it "has button to view dashboard" do
      expect(rendered).to have_link("View dashboard", href: dashboard_path)
    end

    it "button to find out more about NCCE" do
      expect(rendered).to have_link("Learn more about us", href: about_path)
    end
  end
end
