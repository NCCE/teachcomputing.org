# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake fix_unlinked_achievements', type: :task do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:stem_activity) { create(:activity, :stem_learning) }
  let(:fl_activity) { create(:activity, :future_learn) }
  let(:ach) { create(:achievement, user_id: user.id, activity_id: stem_activity.id) }
  let(:ach1) { create(:achievement, user_id: user.id, activity_id: fl_activity.id) }

  before do
    create(:programme_activity, activity_id: stem_activity.id, programme_id: cs_accelerator.id)
    create(:programme_activity, activity_id: fl_activity.id, programme_id: cs_accelerator.id)
    create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
    [ach, ach1].each { |a| a.update(programme_id: nil) }

    allow(Rails.logger).to receive(:warn).at_least(:once)
    task.execute
  end

  it 'fixes the achievements' do
    ach.reload
    expect(ach.programme_id).to eq(cs_accelerator.id)

    ach1.reload
    expect(ach1.programme_id).to eq(cs_accelerator.id)
  end

  it 'logs the success' do
    expect(Rails.logger).to have_received(:warn).with('Fixed: 2')
  end
end
