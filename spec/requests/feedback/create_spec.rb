require "rails_helper"

RSpec.describe FeedbackController do
  let(:user) { create(:user) }
  let(:feedback_params) { { area: "Test area", comment: "Test feedback comment" } }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context "when feedback is successfully submitted" do
      it "saves the feedback and redirects back with a success notice" do        
        post feedback_path(feedback_comment: feedback_params), headers: { "HTTP_REFERER" => root_path }

        expect(FeedbackComment.last.comment).to eq("Test feedback comment")
        expect(flash[:notice]).to eq("Your feedback was successfully submitted")
        expect(response).to redirect_to(root_path)
      end
    end

    context "when feedback submission fails" do
      before do
        allow_any_instance_of(FeedbackComment).to receive(:save).and_return(false)
      end

      it "does not save the feedback and redirects back with an error notice" do
        post feedback_path(feedback_comment: feedback_params), headers: { "HTTP_REFERER" => root_path }

        expect(FeedbackComment.last).to be_nil
        expect(flash[:error]).to eq("There was a problem submitting feedback please try again")
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
