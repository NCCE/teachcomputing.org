require "rails_helper"

RSpec.describe ProgrammeStatusComponent, type: :component do
  let(:programme) { create(:primary_certificate) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme:) }

  before do
    stub_strapi_programme
    described_class.new(user_programme_enrolment:)
  end

  it "should render the wrapper" do
    expect(page).to have_css(".programme-status-wrapper")
  end
end
