require "rails_helper"

RSpec.describe HubsController do
  describe "GET #index" do
    context "when there is no filtering" do
      before do
        get hubs_path
      end

      it "renders the correct template" do
        expect(response).to render_template("index")
      end
    end

    context "when filtering is applied" do
      before do
        get hubs_path, params: {
          location: "York"
        }
      end

      it "renders the correct template" do
        expect(response).to render_template("index")
      end

      it "passes params through to hubs index as expected" do
        location = assigns(:hubs_index).current_location
        expect(location).to eq("York")
      end
    end
  end
end
