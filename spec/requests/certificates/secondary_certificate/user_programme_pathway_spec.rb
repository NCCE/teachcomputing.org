require "rails_helper"

RSpec.describe "Updating user programme pathway", type: :request do
  let(:user) { create(:user) }
  let(:programme) { create(:secondary_certificate) }
  let(:pathway_1) { create(:pathway, programme:) }
  let(:pathway_2) { create(:pathway, programme:) }

  let!(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id,
      pathway_id: pathway_1.id)
  end

  before do
    allow_any_instance_of(AuthenticationHelper)
      .to receive(:current_user).and_return(user)
  end

  describe "PUT update" do
    context "When pathway id is valid" do
      it "updates the pathway ID on the users enrolment" do
        expect(user_programme_enrolment.pathway_id).to eq(pathway_1.id)
        put update_user_pathway_secondary_certificate_path, params: {
          pathway_id: pathway_2.id
        }

        expect(user_programme_enrolment.reload.pathway_id).to eq(pathway_2.id)
      end

      it "redirects to dashboard" do
        put update_user_pathway_secondary_certificate_path, params: {
          pathway_id: pathway_2.id
        }
        expect(response).to redirect_to(secondary_certificate_path)
      end

      it "displays a flash message" do
        put update_user_pathway_secondary_certificate_path, params: {
          pathway_id: pathway_2.id
        }
        expect(flash[:notice]).to match(/Your pathway was changed successfully/)
      end
    end

    context "When pathway id is invalid" do
      it "does not update the pathway ID on the users enrolment" do
        expect(user_programme_enrolment.pathway_id).to eq(pathway_1.id)
        put update_user_pathway_secondary_certificate_path, params: {
          pathway_id: "1111111111111111111"
        }

        expect(user_programme_enrolment.reload.pathway_id).to eq(pathway_1.id)
      end

      it "redirects to dashboard" do
        put update_user_pathway_secondary_certificate_path, params: {
          pathway_id: "1111111111111111111"
        }
        expect(response).to redirect_to(secondary_certificate_path)
      end

      it "displays a flash error message" do
        put update_user_pathway_secondary_certificate_path, params: {
          pathway_id: "1111111111111111111"
        }
        expect(flash[:error]).to match(/Something went wrong updating the pathway/)
      end
    end
  end
end
