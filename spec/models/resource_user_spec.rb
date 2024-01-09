require "rails_helper"

RSpec.describe ResourceUser, type: :model do
  let(:resource_user) { create(:resource_user) }

  describe "validations" do
    before do
      resource_user
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:resource_year) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:resource_year) }
    it { is_expected.to validate_presence_of(:counter) }
  end

  describe "associations" do
    it "belongs to user" do
      expect(resource_user).to belong_to(:user)
    end
  end
end
