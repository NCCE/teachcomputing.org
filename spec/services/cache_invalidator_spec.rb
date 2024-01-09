require "rails_helper"

RSpec.describe CacheInvalidator do
  subject(:invalidate_cache) { described_class.new(resource: resource, identifier: identifier).run }

  let(:fake_store) { double("Cache") }
  let(:identifier) { "cache_identifier" }

  before do
    allow(Rails).to receive(:cache).and_return(fake_store)
    allow(fake_store).to receive(:delete)
    invalidate_cache
  end

  describe "#run" do
    context "when resource is a key_stage" do
      let(:resource) { "key_stage" }

      it "invalidates the relevant cached key_stage" do
        expect(fake_store)
          .to have_received(:delete)
          .with("key_stage--cache_identifier", namespace: "curriculum")
      end

      it "invalidates the cached list of key_stages" do
        expect(fake_store)
          .to have_received(:delete)
          .with("key_stage--all", namespace: "curriculum")
      end
    end

    context "when resource is a unit" do
      let(:resource) { "unit" }

      it "invalidates the relevant cached unit" do
        expect(fake_store)
          .to have_received(:delete)
          .with("unit--cache_identifier", namespace: "curriculum")
      end

      it "does not try to invalidate cached list of units" do
        # we aren't caching a list of all units
        expect(fake_store)
          .not_to have_received(:delete)
          .with("unit--all", namespace: "curriculum")
      end
    end

    context "when a list of identifiers are passed" do
      let(:resource) { "redirect" }
      let(:identifier) { %w[a-lesson another-lesson] }

      it "invalidates the relevant cached unit" do
        expect(fake_store)
          .to have_received(:delete)
          .with("redirect--another-lesson", namespace: "curriculum")

        expect(fake_store)
          .to have_received(:delete)
          .with("redirect--a-lesson", namespace: "curriculum")
      end
    end
  end
end
