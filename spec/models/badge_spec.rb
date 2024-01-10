require "rails_helper"

RSpec.describe Badge, type: :model do
  let(:active_badges) { create_list(:badge, 3, :active) }
  let(:inactive_badges) { create_list(:badge, 3) }

  describe "validations" do
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to validate_presence_of(:academic_year) }
    it { is_expected.to validate_presence_of(:credly_badge_template_id) }
  end

  describe "scopes" do
    describe "#active" do
      before do
        [active_badges, inactive_badges]
      end

      it "only contains badges where active is true" do
        expect(described_class.active).to eq active_badges
        expect(described_class.active).not_to eq inactive_badges
      end
    end
  end
end
