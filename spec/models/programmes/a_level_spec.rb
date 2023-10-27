require 'rails_helper'

RSpec.describe Programmes::ALevel do
  subject { create(:a_level) }

  describe '#mailer' do
    it 'returns the ALevelMailer' do
      expect(subject.mailer).to eq(ALevelMailer)
    end
  end

  describe '#path' do
    it 'returns the path for the programme' do
      expect(subject.path).to eq('/certificate/a-level-certificate')
    end
  end

  describe '#enrol_path' do
    it 'returns the path for the enrol' do
      expect(subject.enrol_path(user_programme_enrolment: { user_id: 'user_id',
                                                              programme_id: 'programme_id' })).to eq('/certificate/a-level-certificate/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id')
    end
  end

  describe '#programme_title' do
    it 'returns correct title' do
      expect(subject.programme_title)
        .to eq('A level subject knowledge')
    end
  end

  describe '#short_name' do
    it 'should return its short name' do
      expect(subject.short_name).to eq 'A Level'
    end
  end

  describe '#programme_objectives' do
    let!(:assessment) { create(:assessment, programme: subject) }
    it 'should return a AssessmentPassRequired followed by PAGs' do
      pags = create_list(:programme_activity_grouping, 2, programme: subject)

      expect(subject.programme_objectives.first).to be_a ProgrammeObjectives::AssessmentPassRequired
      expect(subject.programme_objectives[1..]).to match_array(pags)
    end
  end
end
