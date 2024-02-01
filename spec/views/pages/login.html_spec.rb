require "rails_helper"

RSpec.describe("pages/login", type: :view) do
  before do
    render template: "pages/login", locals: {auth_uri: "/test/123"}
  end

  it "has a title" do
    expect(rendered).to have_css(".hero__heading", text: "Login to your account")
  end

  it "button to log in" do
    expect(rendered).to have_css(".ncce-login__button", text: "Log in")
  end

  it "links to log in to a STEM Learning account" do
    expect(rendered).to have_link("Log in", href: "/test/123")
  end

  it "login button uses POST" do
    expect(rendered).to have_css('a[@href="/test/123"][@data-method="post"]', count: 1)
  end
end
