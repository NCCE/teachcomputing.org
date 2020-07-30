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
end
