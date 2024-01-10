require "rails_helper"

RSpec.describe PagesController do
  let(:user) { create(:user) }

  describe "#login" do
    context "with a current user" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get login_path
      end

      it "should redirect to the dashboard" do
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "without a current user" do
      before do
        get login_path
      end

      it "should redirect to login" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with the source_uri parameter set" do
      before do
        allow_any_instance_of(PagesController).to receive(:render).and_call_original
      end

      it "should append this to the auth url" do
        test_source_uri = "https%3A//www-stage.stem.org.uk/cpd/448804/primary-programming-and-algorithms"

        expect_any_instance_of(PagesController).to receive(:render) do |_method, options|
          expect(options[:locals][:auth_uri]).to eq("/auth/stem?source_uri=#{test_source_uri}")
        end
        get login_path, params: {source_uri: test_source_uri}
      end
    end
  end
end
