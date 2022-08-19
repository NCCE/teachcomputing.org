require 'rails_helper'

describe CurriculumHelper, type: :helper do
  let(:user) { create(:user) }

  describe('#key_stage_list_color') do
    context 'when the key stage is within 1..2' do
      it 'returns the orange class' do
        expect(helper.key_stage_list_color('1')).to eq 'curriculum__list--item-orange'
      end
    end

    context 'when the key stage is not within the range of 1..2' do
      it 'returns the purple class' do
        expect(helper.key_stage_list_color('3')).to eq 'curriculum__list--item-purple'
      end
    end
  end

  describe('#generate_download_url') do
    context 'when logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it 'returns GCSE' do
        expect(helper.generate_download_url('https://google.com')).to eq "https://google.com?user_stem_achiever_contact_no=#{user.stem_achiever_contact_no}"
      end
    end

    context 'when not logged in' do
      it 'returns GCSE' do
        expect(helper.generate_download_url('https://google.com')).to eq 'https://google.com'
      end
    end
  end

  describe('#year_group_title') do
    context 'when the year number contains GCSE' do
      it 'returns GCSE' do
        expect(helper.year_group_title('GCSE')).to eq 'GCSE'
      end
    end

    context 'when the year number contains anything but GCSE' do
      it 'returns Year and its number' do
        expect(helper.year_group_title('1')).to eq 'Year 1'
      end
    end
  end

  describe('.sorted_years') do
    before do
      stub_const('Year', Struct.new(:year, :year_number))
    end

    it 'sorts numeric years correctly' do
      years = [
        Year.new(1, '1'),
        Year.new(3, '3'),
        Year.new(2, '2')
      ]
      expect(helper.sorted_years(years))
        .to eq([
                 Year.new(1, '1'),
                 Year.new(2, '2'),
                 Year.new(3, '3')
               ])
    end

    it 'sorts GCSE and Non-GCSE correctly' do
      years = [
        Year.new(10, 'Non-GCSE'),
        Year.new(11, 'GCSE')
      ]
      expect(helper.sorted_years(years))
        .to eq([
                 Year.new(11, 'GCSE'),
                 Year.new(10, 'Non-GCSE')
               ])
    end
  end

  describe('#lesson_with_range_wording') do

    context 'when a lesson has a range' do
      it 'returns to wording' do
        lesson_order = 42
        lesson_range = 45
        expect(helper.lesson_with_range_wording(lesson_order, lesson_range)).to eq('Lesson 42 to 45')
      end
    end

    context 'when a lesson does not have a range' do
      it 'returns and wording' do
        lesson_order = 42
        lesson_range =
        expect(helper.lesson_with_range_wording(lesson_order, lesson_range)).to eq('Lesson 42')
      end
    end
  end
end
