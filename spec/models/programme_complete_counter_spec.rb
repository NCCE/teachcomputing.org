require "rails_helper"

RSpec.describe ProgrammeCompleteCounter, type: :model do
  let(:programme) { create(:programme) }
  let(:programme_complete_counter) { create(:programme_complete_counter, counter: 0, programme_id: programme.id) }

  describe "associations" do
    it "belongs to programme" do
      expect(programme_complete_counter).to belong_to(:programme)
    end
  end

  describe "#get_next_number" do
    context "when update is successful" do
      it "increments the counter" do
        expect { programme_complete_counter.get_next_number }.to change { programme_complete_counter.counter }.by(1)
      end

      it "returns the counter + 1" do
        count = programme_complete_counter.get_next_number
        expect(programme_complete_counter.get_next_number).to eq(count + 1)
      end
    end

    context "when update fails" do
      before do
        allow(programme_complete_counter).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError)
        allow(Sentry).to receive(:set_tags)
        allow(Sentry).to receive(:capture_exception)
      end

      it "sets Sentry tags with the programme" do
        programme_complete_counter.get_next_number rescue nil # standard:disable Style/RescueModifier
        expect(Sentry).to have_received(:set_tags).with(programme: programme)
      end

      it "captures the exception with Sentry" do
        programme_complete_counter.get_next_number rescue nil # standard:disable Style/RescueModifier
        expect(Sentry).to have_received(:capture_exception).with(instance_of(ActiveRecord::ActiveRecordError))
      end
    end
  end
end
