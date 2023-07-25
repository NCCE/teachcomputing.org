# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake mark_teachers_as_completed', type: :task do
  let(:programme) { create(:primary_certificate) }
  let(:programme_complete_counter) { create(:programme_complete_counter, programme: programme) }
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

  let(:csv_file_title) { 'test_csv.csv' }

  before do
    programme_complete_counter
    ## qualified user ##
    enrolment1
    qu_ach1
    ## pending user ##
    enrolment2
    pu_ach1
    ## unqualified user ##
    enrolment3
    uu_ach1

    csv_string = [qualified_user, pending_user, unqualified_user].map(&:stem_user_id).join("\n")

    File.delete(csv_file_title) if File.exist? csv_file_title # ensure there isn't a left over file
    File.write(csv_file_title, csv_string)
  end

  after do
    File.delete(csv_file_title) if File.exist? csv_file_title
  end

  it 'Should return the users which have have been marked as completed' do
    expect do
      task.execute(file: csv_file_title, certificate: 'primary_certificate')
    end.to output(
      <<~OUTPUT
        #{qualified_user.stem_user_id}
        #{pending_user.stem_user_id}
        Marked 2 users as completed.
        END OF OUTPUT
      OUTPUT
    ).to_stdout
  end

  it 'Should mark their records as completed' do
    task.execute(file: csv_file_title, certificate: 'primary_certificate')

    expect(enrolment1.in_state?(:complete)).to be true
    expect(enrolment2.in_state?(:complete)).to be true
  end

  it 'Should increment the programme completed counter' do
    expect do
      task.execute(file: csv_file_title, certificate: 'primary_certificate')
    end.to change { programme_complete_counter.reload.counter }.by(2)
  end
end
