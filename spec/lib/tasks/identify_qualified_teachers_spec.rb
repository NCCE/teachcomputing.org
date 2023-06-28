# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake identify_qualified_teachers', type: :task do
  let(:programme) { create(:primary_certificate) }
  let(:grouping1) do
    create(:programme_activity_grouping,
           :with_activities,
           title: 'courses',
           sort_key: 1,
           required_for_completion: 1,
           programme:)
  end

  let(:qualified_user) { create(:user, email: 'qualified_user@example.com', stem_user_id: '0001') }
  let(:enrolment1) { create(:user_programme_enrolment, user: qualified_user, programme:) }
  let(:qu_ach1) { create(:completed_achievement, user: qualified_user, activity: grouping1.programme_activities.first.activity, programme:) }

  let(:pending_user) { create(:user, email: 'pending_user@example.com', stem_user_id: '0002') }
  let(:enrolment2) do
    enrolment2 = create(:user_programme_enrolment, user: pending_user, programme:)
    enrolment2.transition_to(:pending)
    enrolment2
  end
  let(:pu_ach1) { create(:completed_achievement, user: pending_user, activity: grouping1.programme_activities.first.activity, programme:) }

  let(:unqualified_user) { create(:user, email: 'unqualified_user@example.com', stem_user_id: '0003') }
  let(:enrolment3) { create(:user_programme_enrolment, user: unqualified_user, programme:) }
  let(:uu_ach1) do
    ach = create(:achievement, user: unqualified_user, activity: grouping1.programme_activities.first.activity, programme:)
    ach.transition_to(:in_progress)
    ach
  end

  before do
    create(:secondary_certificate)
    ## qualified user ##
    enrolment1
    qu_ach1
    ## pending user ##
    enrolment2
    pu_ach1
    ## unqualified user ##
    enrolment3
    uu_ach1
  end

  it 'identifies the qualified primary user' do
    expect do
      task.execute(certificate: 'primary_certificate')
    end.to output(
      <<~OUTPUT
        stem_user_id,email
        "0001","qualified_user@example.com"
        Identified 1 users.
        END OF OUTPUT
      OUTPUT
    ).to_stdout
  end

  it 'identifies no secondary users' do
    expect do
      task.execute(certificate: 'secondary_certificate')
    end.to output(
      <<~OUTPUT
        stem_user_id,email
        Identified 0 users.
        END OF OUTPUT
      OUTPUT
    ).to_stdout
  end
end
