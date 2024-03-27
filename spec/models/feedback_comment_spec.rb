require "rails_helper"

RSpec.describe FeedbackComment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:area) }
    it { is_expected.to validate_presence_of(:comment) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
