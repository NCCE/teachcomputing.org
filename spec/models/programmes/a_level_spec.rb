require 'rails_helper'

RSpec.describe Programmes::ALevel do
  subject { create(:a_level) }

  describe '#path' do
    it 'returns the path for the programme' do
      expect(subject.path).to eq('/certificate/a-level')
    end
  end

  describe '#enrol_path' do
    it 'returns the path for the enrol' do
      expect(subject.enrol_path(user_programme_enrolment: { user_id: 'user_id',
                                                              programme_id: 'programme_id' })).to eq('/certificate/a-level/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id')
    end
  end

  describe '#programme_title' do
    it 'returns correct title' do
      expect(subject.programme_title)
        .to eq('A level subject knowledge')
    end
  end
end
