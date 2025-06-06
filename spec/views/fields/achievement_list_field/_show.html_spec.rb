require "rails_helper"

RSpec.describe "fields/achievement_list_field/show", type: :view do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:completed_achievement) { create(:completed_achievement, user:, evidence: ["I did the thing. \n This is more on a new line. \n Testing another line in the text."]) }
  let(:ongoing_achievement) { create(:achievement, user:) }
  let(:rejected_achievement) { create(:rejected_achievement, user:) }
  let!(:programme_activities) {
    create(:programme_activity, programme:, activity: completed_achievement.activity)
    create(:programme_activity, programme:, activity: ongoing_achievement.activity)
    create(:programme_activity, programme:, activity: rejected_achievement.activity)
  }

  before do
    completed_achievement
    ongoing_achievement
    rejected_achievement
    user.reload
    render partial: subject, locals: {field: instance_double(
      "AchievementListField",
      attribute: :achievements,
      data: user.achievements,
      state_list: StateMachines::AchievementStateMachine.states
    )}
  end

  it "should list achievments" do
    expect(rendered).to have_css(".achievement", count: 3)
  end

  it "should set correct data attributes" do
    expect(rendered).to have_css("[data-current-state='complete']", count: 1)
    expect(rendered).to have_css("[data-current-state='rejected']", count: 1)
    expect(rendered).to have_css("[data-current-state='enrolled']", count: 1)
  end

  it "should show reject option on complete" do
    expect(rendered).to have_css(".button", count: 1, text: "Reject Evidence")
  end

  it "should convert new lines to html line break" do
    expect(rendered).to have_css(".supplied-evidence_block br", count: 2)
  end
end
