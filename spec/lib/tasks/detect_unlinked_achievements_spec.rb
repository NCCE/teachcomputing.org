# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake detect_unlinked_achievements', type: :task do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:stem_activity) { create(:activity, :stem_learning) }
  let(:fl_activity) { create(:activity, :future_learn) }

  before do
    allow(Sentry).to receive(:capture_message)

    create(:programme_activity, activity_id: stem_activity.id, programme_id: cs_accelerator.id)
    create(:programme_activity, activity_id: fl_activity.id, programme_id: cs_accelerator.id)
  end

  context 'with unlinked achievements' do
    it 'skips matches where the user has no enrolment' do
      ach = create(:achievement, user_id: user.id)
      ach.update(programme_id: nil)
      task.execute
      expect(Sentry).not_to have_received(:capture_message)
    end

    it 'detects the expected matches' do
      create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
      ach = create(:achievement, user_id: user.id, activity_id: stem_activity.id)
      ach1 = create(:achievement, user_id: user.id, activity_id: fl_activity.id)
      [ach, ach1].each { |a| a.update(programme_id: nil) }
      task.execute
      expect(Sentry).to have_received(:capture_message).with("Found 2 unlinked achievements for cs-accelerator: #{ach.id}, #{ach1.id}")
    end
  end

  context 'with linked achievements' do
    it 'does not detect any matches' do
      create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
      create(:achievement, user_id: user.id, activity_id: stem_activity.id, programme_id: cs_accelerator.id)
      task.execute
      expect(Sentry).not_to have_received(:capture_message)
    end
  end
end
