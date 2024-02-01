require "rails_helper"

RSpec.describe ProgrammeCompleteCounter, type: :model do
  let(:programme) { create(:programme) }
  let(:programme_complete_counter) { create(:programme_complete_counter, counter: 0, programme_id: programme.id) }

  describe "associations" do
    it "belongs to programme" do
      expect(programme_complete_counter).to belong_to(:programme)
    end

    it "increments the counter" do
      expect { programme_complete_counter.get_next_number }.to change { programme_complete_counter.counter }.by(1)
    end

    it "returns the counter + 1" do
      count = programme_complete_counter.get_next_number
      expect(programme_complete_counter.get_next_number).to eq(count + 1)
    end
  end
end
