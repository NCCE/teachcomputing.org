require "rails_helper"

RSpec.describe Certificates::SecondaryCertificateController do
  let(:user) { create(:user) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:secondary_certificate_groupings) { create_list(:programme_activity_grouping, 3, programme_id: secondary_certificate.id) }
  let(:cqf_group) {
    create(:programme_activity_groupings_cqf_assessment, :with_activities, programme_id: secondary_certificate.id)
  }
  let(:pd_group) {
    create(:programme_activity_groupings_professional_development_activity, :with_activities, programme_id: secondary_certificate.id)
  }
  let(:secondary_enrolment) { create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id) }

  describe "#show" do
    context "when user is logged in" do
      before do
        secondary_certificate
        secondary_certificate_groupings
        cqf_group
        pd_group
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      context "when user is enrolled" do
        before do
          secondary_enrolment
          get secondary_certificate_path
        end

        it "renders the show template" do
          expect(response).to render_template("show")
        end

        it "assigns programme" do
          expect(assigns(:programme)).to eq(secondary_certificate)
        end

        it "assigns programme_activity_groupings" do
          expect(assigns(:community_groups)).to all(be_a(ProgrammeActivityGrouping))
          expect(assigns(:professional_development_groups)).to all(be_a(ProgrammeActivityGrouping))
        end

        it "assigns cqf_group and pd_group separately from professional_development_groups" do
          expect(assigns(:cqf_group)).to be_a(ProgrammeActivityGrouping)
          expect(assigns(:pd_group)).to be_a(ProgrammeActivityGrouping)
          expect(assigns(:professional_development_groups)).not_to include(assigns(:cqf_group), assigns(:pd_group))
        end

        it "renders the standalone activity group partial for CQF and PD" do
          expect(response).to render_template(partial: "certificates/secondary_certificate/_standalone_activity_group", count: 2)
        end
      end

      context "when user is not enrolled" do
        it "redirects if not enrolled" do
          get secondary_certificate_path
          expect(response).to redirect_to(secondary_path)
        end
      end

      describe "when user is enrolled" do
        before do
          secondary_enrolment
          get secondary_certificate_path
        end

        it "renders the correct template" do
          expect(response).to render_template("show")
        end
      end
    end

    context "when the user is not logged in" do
      it "redirects to login" do
        get secondary_certificate_path
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
      end
    end
  end
end
