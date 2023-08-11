require 'rails_helper'

describe CertificateHelper, type: :helper do
  describe '#format_activity_title' do
    let(:group) { create(:programme_activity_grouping, required_for_completion:, title:) }
    let(:required_for_completion) { 1 }
    let!(:programme_activities) { create_list(:programme_activity, 3, programme_activity_grouping: group) }
    let(:title) { 'Encourage girls into computer science' }

    it 'should make the first word of the title bold' do
      expect(helper.format_activity_title(group)).to start_with '<strong>Encourage</strong> girls'
    end

    context 'when the count for required for completion is not equal to the quantity of activities' do
      context 'when the count required for completion is one' do
        it 'should state the quantity required for completion with correct singlars' do
          expect(helper.format_activity_title(group)).to end_with 'by completing <strong>at least one</strong> activity'
        end
      end

      context 'when the count required for completion is two' do
        let(:required_for_completion) { 2 }

        it 'should state the quantity required for completion with correct plurals' do
          expect(helper.format_activity_title(group)).to end_with 'by completing <strong>at least two</strong> activities'
        end
      end
    end

    context 'when the count for required for completion is equal to the quantity of activities' do
      let(:required_for_completion) { 3 }

      it 'shouldn\'t state how many are required for completion' do
        expect(helper.format_activity_title(group)).to eq '<strong>Encourage</strong> girls into computer science'
      end
    end
  end

  describe '#sort_community_activities_with_legacy_pathway' do
    context 'when pathway is nil' do
      let(:programme) { create(:programme) }
      let(:programme_activity_grouping) { create(:programme_activity_grouping, programme:) }
      let(:legacy_programme_activities) { create_list(:programme_activity, 4, legacy: true, programme_activity_grouping:) }
      let(:programme_activities) { create_list(:programme_activity, 4, programme_activity_grouping:) }
      let(:user) { create(:user) }

      it 'should return just the legacy programme activities' do
        expect(
          helper.sort_community_activities_with_legacy_pathway(
            programme_activities: programme_activity_grouping.programme_activities,
            current_user: user
          )
        ).to match_array legacy_programme_activities
      end

      context 'when pathway is present' do
        let(:pathway) { create(:pathway, programme:) }

        before do
          (legacy_programme_activities.first(3) + programme_activities.first(3)).each do |programme_activity|
            create(:pathway_activity, activity: programme_activity.activity, pathway:)
          end
        end

        context 'when the user has not completed any activities' do
          it 'should only return non legacy activities belonging to the pathway' do
            expect(
              helper.sort_community_activities_with_legacy_pathway(
                programme_activities: programme_activity_grouping.programme_activities,
                pathway:,
                current_user: user
              )
            ).to match_array programme_activities.first(3)
          end
        end

        context 'when the user has completed a not legacy activity' do
          before do
            create(:completed_achievement, activity: programme_activities.third.activity, user:)
          end

          it 'should return completed activity before non-completed' do
            output = helper.sort_community_activities_with_legacy_pathway(
              programme_activities: programme_activity_grouping.programme_activities,
              pathway:,
              current_user: user
            )

            expect(output.first).to eq programme_activities.third
            expect(output[1..]).to match_array programme_activities[0..1]
          end
        end

        context 'when the user has completed legacy and non-legacy activities' do
          before do
            create(:completed_achievement, activity: programme_activities.third.activity, user:)
            create(:completed_achievement, activity: legacy_programme_activities.third.activity, user:)
          end

          it 'should return legacy before completed activity before non-completed' do
            output = helper.sort_community_activities_with_legacy_pathway(
              programme_activities: programme_activity_grouping.programme_activities,
              pathway:,
              current_user: user
            )

            expect(output.first).to eq legacy_programme_activities.third
            expect(output.second).to eq programme_activities.third
            expect(output[2..]).to match_array programme_activities[0..1]
          end
        end
      end
    end
  end
end
