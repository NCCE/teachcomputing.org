require 'rails_helper'

RSpec.describe Achiever::Course::Delegate do
  let(:delegate) { described_class.find_by_achiever_contact_number('id-101').first }

  describe 'accessor methods' do
    before do
      stub_delegate
    end

    it 'responds to course_template_no' do
      expect(delegate).to respond_to(:course_template_no)
    end

    it 'responds to is_fully_attended' do
      expect(delegate).to respond_to(:is_fully_attended)
    end
  end

  describe 'constants' do
    describe 'RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::Delegate::RESOURCE_PATH).not_to eq nil
      end
    end
  end

  describe 'class methods' do
    describe '#find_by_achiever_contact_number' do
      it 'returns an array' do
        stub_delegate
        expect(described_class.find_by_achiever_contact_number('id-101')).to be_an Array
      end
    end
  end
end
