require "rails_helper"

RSpec.describe Credly::Request do
  let(:user) { create(:user, id: "59493a41-b7de-43ec-802c-8bdeeb329037") }
  let(:badge_template_id) { "00cd7d3b-baca-442b-bce5-f20666ed591b" }
  describe "#run" do
    context "when the request is not a SUCCESS" do
      it "it raises Credly::Error" do
        stub_issue_badge_failure(user.id, badge_template_id)

        body = {
          "recipient_email" => user.email,
          "issued_to_first_name" => user.first_name,
          "issued_to_last_name" => user.last_name,
          "badge_template_id" => badge_template_id,
          "issued_at" => DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z"),
          "issuer_earner_id" => user.id
        }.to_json

        expect do
          Credly::Request.run("organizations/e52b9e79-9ddb-4110-9883-ae2c44a7440e/badges", body)
        end.to raise_error(Credly::Error)
      end
    end
  end
end
