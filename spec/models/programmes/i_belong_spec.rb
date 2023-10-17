require 'rails_helper'

RSpec.describe Programmes::IBelong do
  let(:programme) { create(:i_belong) }

  describe '#path' do
    it 'returns the path for the programme' do
      expect(programme.path).to eq('/certificate/i-belong')
    end
  end

  describe '#pending_delay' do
    it 'should return 14 days' do
      expect(programme.pending_delay).to eq 14.days
    end
  end

  describe '#enrol_path' do
    it 'returns the path for the enrol' do
      expect(programme.enrol_path(user_programme_enrolment: { user_id: 'user_id',
                                                              programme_id: 'programme_id' })).to eq('/certificate/i-belong/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id')
    end
  end

  describe '#programme_title' do
    it 'returns correct title' do
      expect(programme.programme_title)
        .to eq('I Belong: encouraging girls into computer science')
    end
  end

  describe '#certificate_name_for_user' do
    it 'should return the user\'s i_belong_certificate_name' do
      user = create(:user, i_belong_certificate_name: 'test school name')

      expect(programme.certificate_name_for_user(user)).to eq user.i_belong_certificate_name
    end
  end

  describe '#short_name' do
    it 'should return its short name' do
      expect(programme.short_name).to eq 'I belong'
    end
  end
end
