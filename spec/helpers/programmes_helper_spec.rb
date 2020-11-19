require 'rails_helper'

describe ProgrammesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:enrolment) do
    create(:user_programme_enrolment,
           user: user,
           programme: create(:cs_accelerator))
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

  describe('#index_to_word_ordinal') do
    it 'returns "0th" when argument is -1' do
      expect(index_to_word_ordinal(-1)).to eq('0th')
    end

    it 'returns "first" when argument is nil' do
      expect(index_to_word_ordinal(nil)).to eq('first')
    end

    it 'returns "first" when argument is 0' do
      expect(index_to_word_ordinal(0)).to eq('first')
    end

    it 'returns "-10th" when argument is -11' do
      expect(index_to_word_ordinal(-11)).to eq('-10th')
    end

    it 'returns "tenth" when argument is 9' do
      expect(index_to_word_ordinal(9)).to eq('tenth')
    end

    it 'returns "third" when argument is 2' do
      expect(index_to_word_ordinal(2)).to eq('third')
    end

    it 'returns "seventh" when argument is 6' do
      expect(index_to_word_ordinal(6)).to eq('seventh')
    end
  end

  describe('#certificate_progress_for_user') do
    context 'when a user is enrolled on a programme' do
      it 'returns a string' do
        enrolment
        expect(helper.certificate_progress_for_user(user)).to be_a(String)
      end
    end

    context 'when a user is not enrolled on a programme' do
      it 'returns nil' do
        expect(helper.certificate_progress_for_user(user)).to eq nil
      end
    end
  end
end
