require "rails_helper"

RSpec.describe PagesController do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end

  describe "GET #subject-knowledge" do
    before do
      user
      programme
    end

    context "when user is not logged in" do
      before do
        get cs_accelerator_path
      end

      it "shows the page" do
        expect(response).to render_template("pages/enrolment/subject_knowledge")
      end
    end

    context "when user is not enrolled on programme" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get cs_accelerator_path
      end

      it "shows the page" do
        expect(response).to render_template("pages/enrolment/subject_knowledge")
      end
    end

    context "when user is enrolled on programme" do
      it "redirects to the programme page" do
        user_programme_enrolment
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        user_programme_enrolment
        get cs_accelerator_path
        expect(response).to redirect_to(cs_accelerator_certificate_path)
      end
    end
  end
end
