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

  it "login button POSTs to log in to a STEM Learning account, outside of Turbo" do
    expect(rendered).to have_css('form[action="/test/123"][method="post"][data-turbo="false"] button', text: "Log in", count: 1)
  end
end
