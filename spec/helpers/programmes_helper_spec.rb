require 'rails_helper'

describe ProgrammesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_courses) { create_list(:activity, 2, :future_learn, credit: 20) }
  let(:face_to_face_courses) { create_list(:activity, 2, :stem_learning, credit: 20) }

  let(:setup_partially_complete_certificate) do
    user_programme_enrolment
    activities = [diagnostic_tool_activity].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      if activity.category == 'online'
        achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
        achievement.set_to_complete
      end
    end
    diagnostic_achievement
  end

  let(:setup_complete_certificate) do
    user_programme_enrolment

    activities = [diagnostic_tool_activity].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.set_to_complete
    end
  end

  describe('#certificate_number') do
    it 'defaults to 0 for missing param' do
      expect(certificate_number(nil, DateTime.parse('2001-02-03T04:05:06+07'))).to eq('200102-000')
    end

    it 'adds one to index correctly' do
      expect(certificate_number(1, DateTime.parse('2001-02-03T04:05:06+07'))).to eq('200102-001')
    end

    it 'pads numbers < 100 correctly' do
      expect(certificate_number(10, DateTime.parse('2001-02-03T04:05:06+07'))).to eq('200102-010')
      expect(certificate_number(99, DateTime.parse('2001-02-03T04:05:06+07'))).to eq('200102-099')
    end

    it 'allows numbers > 100 correctly' do
      expect(certificate_number(100, DateTime.parse('2001-02-03T04:05:06+07'))).to eq('200102-100')
      expect(certificate_number(2845, DateTime.parse('2001-02-03T04:05:06+07'))).to eq('200102-2845')
    end
  end

  describe('#to_word_ordinal') do
    it 'returns "0th" when argument is nil' do
      expect(to_word_ordinal(nil)).to eq('0th')
    end

    it 'returns "first" when argument is 1' do
      expect(to_word_ordinal(1)).to eq('first')
    end

    it 'returns "0th" when argument is 0' do
      expect(to_word_ordinal(0)).to eq('0th')
    end

    it 'returns "-10th" when argument is -10' do
      expect(to_word_ordinal(-10)).to eq('-10th')
    end

    it 'returns "tenth" when argument is 10' do
      expect(to_word_ordinal(10)).to eq('tenth')
    end

    it 'returns "third" when argument is 3' do
      expect(to_word_ordinal(3)).to eq('third')
    end

    it 'returns "seventh" when argument is 7' do
      expect(to_word_ordinal(7)).to eq('seventh')
    end
  end

  describe('#credits_for_accelerator') do
    it 'throws exception without the user' do
      expect {
        helper.credits_for_accelerator(nil, nil)
      }.to raise_error(NoMethodError)
    end

    it 'throws exception without the programme' do
      expect {
        helper.credits_for_accelerator(user, nil)
      }.to raise_error(NoMethodError)
    end

    it 'yields zero when user is not enrolled' do
      expect { |b| helper.credits_for_accelerator(user, programme, &b) }.to yield_with_args(0.0)
    end

    context 'when user hasn\'t done enough activities' do
      before do
        setup_partially_complete_certificate
      end

      it 'returns correct score for credits' do
        expect { |b| helper.credits_for_accelerator(user, programme, &b) }.to yield_with_args(40.0)
      end
    end

    context 'when user has done enough activities' do
      before do
        setup_complete_certificate
      end

      it 'returns true' do
        expect { |b| helper.credits_for_accelerator(user, programme, &b) }.to yield_with_args(80.0)
      end
    end
  end

  describe('#can_take_accelerator_test?') do
    context 'when user hasn\'t done enough activities' do
      before do
        setup_partially_complete_certificate
      end

      it 'returns true' do
        expect(helper.can_take_accelerator_test?(user, programme)).to eq false
      end
    end

    context 'when user has done enough activities' do
      before do
        setup_complete_certificate
      end

      it 'returns true' do
        expect(helper.can_take_accelerator_test?(user, programme)).to eq true
      end
    end
  end
end
