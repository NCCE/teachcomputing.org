require 'rails_helper'

RSpec.describe Credly::Connection do
  describe '#api' do
    it 'is a Faraday::Connection class' do
      expect(described_class.api.class).to eq Faraday::Connection
    end
  end
end
