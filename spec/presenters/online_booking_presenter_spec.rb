require 'rails_helper'

RSpec.describe OnlineBookingPresenter do
  let(:course) { Achiever::Course::Template.all.first }

  describe 'title' do
    it { expect(described_class.new.title).to eq('Join this course') }
  end

  describe 'authenticated_title' do
    it { expect(described_class.new.authenticated_title).to eq('Join on FutureLearn') }
  end

  describe 'enrolled_title' do
    it { expect(described_class.new.enrolled_title).to eq('You are enrolled on this course') }
  end

  describe 'completed_title' do
    it { expect(described_class.new.completed_title).to eq("You've completed this course") }
  end

  describe 'enrolled_introduction' do
    it { expect(described_class.new.enrolled_introduction).to eq('You will be taken to the FutureLearn website for further details.') }
  end

  describe 'introduction' do
    it { expect(described_class.new.introduction).to eq('You will be taken to the FutureLearn website to create an account and sign up for online courses.') }
  end

  describe 'unauthenticated_booking_button_title' do
    it { expect(described_class.new.unauthenticated_booking_button_title).to eq('Login to join') }
  end

  describe 'enrolled_button_title' do
    it { expect(described_class.new.enrolled_button_title).to eq('Continue on FutureLearn') }
  end

  describe 'completed_button_title' do
    it { expect(described_class.new.completed_button_title).to eq('View course on FutureLearn') }
  end

  describe 'completed_button_introduction' do
    it { expect(described_class.new.completed_button_introduction).to eq('You will be taken to the FutureLearn website for further details.') }
  end
end
