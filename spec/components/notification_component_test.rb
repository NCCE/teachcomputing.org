require "rails_helper"

RSpec.describe NotificationComponent, type: :component do
  let!(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }
  let!(:enrolment) do
    create(:user_programme_enrolment, user: user, programme: programme, created_at: 1.day.ago)
  end

  before do
    allow(programme).to receive(:enough_activities_for_test?).with(user).and_return(true)

    alertable = programme.show_notification_for_test?(user) ? programme : nil
    render_inline(described_class.new(alertable: alertable))
  end

  it "renders a wrapper element" do
    expect(page).to have_css(".alert-component", count: 1)
  end

  it "renders an element for each incomplete enrolment" do
    expect(page).to have_css(".govuk-body-s", count: 1)
  end
end
