require "rails_helper"

RSpec.describe CurriculumClient::Queries::BaseQuery do
  let(:url) { CurriculumClient::Connection::CURRICULUM_APP_URL }

  before do
    client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
    allow(described_class).to receive(:client).and_return(client)
    stub_a_valid_request
  end

  describe "queries" do
    it "pass the expected params" do
      expect(described_class.one(context: :keyStage,
        fields: "id",
        params: {slug: "key-stage-0"},
        cache_key: "cache-key"))
        .to have_requested(:post, url)
        .with(body: hash_including({variables: {slug: "key-stage-0"}}))

      expect(described_class.one(context: :keyStage,
        fields: "id",
        params: {id: "an_id"},
        cache_key: "cache-key"))
        .to have_requested(:post, url)
        .with(body: hash_including({variables: {id: "an_id"}}))
    end

    it "use only the specified fields" do
      expect(described_class.all(context: :yearGroups,
        fields: "id slug units { id }",
        cache_key: "cache-key")).to have_requested(:post, url)
        .with(body: /yearGroups\s\{\\n\s+id\\n\s+slug\\n\s+units\s\{\\n\s+id\\n\s+\}\\n\s+\}\\n\}/)
    end
  end
end
