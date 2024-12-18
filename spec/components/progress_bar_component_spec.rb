require "rails_helper"

RSpec.describe ProgressBarComponent, type: :component do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:activity_not_enough_credits) { create(:activity, credit: 10) }
  let(:activity_enough_credits) { create(:activity, credit: 100) }

  let!(:primary_programme_activity_groupings) do
    create_list(:programme_activity_groupings_credit_counted, 3, programme: primary_certificate).tap do |groupings|
      groupings[0].update(progress_bar_title: "Attend required CPD", multi_stage_group: true, required_credit_count: 50)
      groupings[1].update(progress_bar_title: "Put into practice")
      groupings[2].update(progress_bar_title: "Share with others")
    end
  end

  describe "with primary certificate" do
    context "with no objectives" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

        render_inline(
          described_class.new(
            programme: primary_certificate
          )
        )
      end

      it "renders the correct title" do
        expect(page).to have_css("h2", text: "Progress bar")
      end

      it "renders the correct body text" do
        expect(page).to have_css("p", text: "The key steps to earn your Teach primary computing certificate")
      end

      it "renders the objectives" do
        expect(page).to have_css(".progress-bar-component__objective", count: 5)
      end

      it "renders the objective titles" do
        expect(page).to have_css("p", text: "Enrol")
        expect(page).to have_css("p", text: "Book required CPD")
        expect(page).to have_css("p", text: "Attend required CPD")
        expect(page).to have_css("p", text: "Put into practice")
        expect(page).to have_css("p", text: "Share with others")
      end

      it "renders only one completed objective icon" do
        expect(page).to have_css(".icon-ticked-circle", count: 1)
        expect(page).to have_css(".icon-blank-circle", count: 4)
      end

      it "has primary spacing class" do
        expect(page).to have_css(".progress-bar-component__objectives-wrapper-primary")
      end
    end

    context "with booked cpd" do
      let(:in_progress_achievement) { create(:in_progress_achievement, activity: activity_not_enough_credits) }
      context "with not enough credits" do
        let(:not_enough_credits_programme_activity) {
          create(:programme_activity,
            programme: primary_certificate,
            activity: activity_not_enough_credits)
        }

        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
          allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

          user.achievements << in_progress_achievement
          primary_programme_activity_groupings[0].programme_activities << not_enough_credits_programme_activity

          render_inline(
            described_class.new(
              programme: primary_certificate
            )
          )
        end

        it "renders the correct icon status images" do
          expect(page).to have_css(".icon-ticked-circle", count: 1)
          expect(page).to have_css(".icon-pending-circle", count: 1)
          expect(page).to have_css(".icon-blank-circle", count: 3)
        end
      end

      context "with enough credits" do
        let(:enough_credits_programme_activity) {
          create(:programme_activity,
            programme: primary_certificate,
            activity: activity_enough_credits)
        }
        let(:in_progress_achievement) { create(:in_progress_achievement, activity: activity_enough_credits) }

        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
          allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

          user.achievements << in_progress_achievement
          primary_programme_activity_groupings[0].programme_activities << enough_credits_programme_activity

          render_inline(
            described_class.new(
              programme: primary_certificate
            )
          )
        end

        it "renders the correct icon status images" do
          expect(page).to have_css(".icon-ticked-circle", count: 2)
          expect(page).to_not have_css(".icon-pending-circle")
          expect(page).to have_css(".icon-blank-circle", count: 3)
        end
      end
    end

    context "with completed cpd" do
      context "with not enough credits" do
        let(:not_enough_credits_programme_activity) {
          create(:programme_activity,
            programme: primary_certificate,
            activity: activity_not_enough_credits)
        }
        let(:completed_achievement) { create(:completed_achievement, activity: activity_not_enough_credits) }

        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
          allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

          user.achievements << completed_achievement
          primary_programme_activity_groupings[0].programme_activities << not_enough_credits_programme_activity

          render_inline(
            described_class.new(
              programme: primary_certificate
            )
          )
        end

        it "renders the correct icon status images" do
          expect(page).to have_css(".icon-ticked-circle", count: 1)
          expect(page).to have_css(".icon-pending-circle", count: 1)
          expect(page).to have_css(".icon-blank-circle", count: 3)
        end
      end

      context "with enough credits" do
        let(:enough_credits_programme_activity) {
          create(:programme_activity,
            programme: primary_certificate,
            activity: activity_enough_credits)
        }
        let(:completed_achievement) { create(:completed_achievement, activity: activity_enough_credits) }

        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
          allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

          user.achievements << completed_achievement
          primary_programme_activity_groupings[0].programme_activities << enough_credits_programme_activity

          render_inline(
            described_class.new(
              programme: primary_certificate
            )
          )
        end

        it "renders the correct icon status images" do
          expect(page).to have_css(".icon-ticked-circle", count: 2)
          expect(page).to_not have_css(".icon-pending-circle")
          expect(page).to have_css(".icon-blank-circle", count: 3)
        end
      end
    end

    context "with booked and completed cpd" do
      let(:programme_activity) {
        create(:programme_activity,
          programme: primary_certificate,
          activity: activity_enough_credits)
      }
      let(:activity_two) { create(:activity, credit: 100) }
      let(:programme_activity_two) {
        create(:programme_activity,
          programme: primary_certificate,
          activity: activity_two)
      }

      let(:completed_achievement) { create(:completed_achievement, activity: activity_enough_credits) }
      let(:in_progress_achievement) { create(:in_progress_achievement, activity: activity_two) }

      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        allow(primary_certificate).to receive(:user_enrolled?).with(user).and_return(true)

        user.achievements << completed_achievement << in_progress_achievement
        primary_programme_activity_groupings[0].programme_activities << programme_activity << programme_activity_two

        render_inline(
          described_class.new(
            programme: primary_certificate
          )
        )
      end

      it "renders the correct icon status images" do
        expect(page).to have_css(".icon-ticked-circle", count: 3)
        expect(page).to_not have_css(".icon-pending-circle")
        expect(page).to have_css(".icon-blank-circle", count: 2)
      end
    end
  end
end
