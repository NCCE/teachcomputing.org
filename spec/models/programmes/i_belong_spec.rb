require 'rails_helper'

RSpec.describe Programmes::IBelong do
  let(:programme) { create(:i_belong) }

  describe '#path' do
    it 'returns the path for the programme' do
      expect(programme.path).to eq('/certificate/i-belong')
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
    it 'should return the user\'s school name' do
      user = create(:user, school_name: 'test school name')

      expect(programme.certificate_name_for_user(user)).to eq user.school_name
    end
  end
end
