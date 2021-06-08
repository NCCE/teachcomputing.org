require 'rails_helper'

RSpec.describe HubRegion, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:order) }
  it { is_expected.to have_many(:hubs) }
end
