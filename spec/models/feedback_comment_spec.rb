require 'rails_helper'

RSpec.describe FeedbackComment, type: :model do
  it { is_expected.to validate_presence_of(:area) }
  it { is_expected.to validate_presence_of(:comment) }
end
