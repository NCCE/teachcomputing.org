require 'rails_helper'

RSpec.describe Achiever::User::Achievement do
  let(:achievement) { create(:achievement) }
  let(:achiever_achievement) { described_class.new(achievement) }

  describe 'constants' do
    describe 'RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::User::Achievement::RESOURCE_PATH).not_to eq nil
      end
    end
  end

  describe 'class methods' do
    describe '#send' do
      before do
        stub_post_achievement
      end

      it 'returns an OpenStruct' do
        expect(achiever_achievement.sync).to be_an OpenStruct
      end
    end
  end
end
