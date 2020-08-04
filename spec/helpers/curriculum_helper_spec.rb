require 'rails_helper'

describe CurriculumHelper, type: :helper do
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
end
