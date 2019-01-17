require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let(:user) { create(:user) }
  let(:achievements) { create(:achievements, user: user) }

  before do
    render
  end

  it 'has the signed up item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to NCCE')
  end

  it 'has the dummy activity' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Completed online course Object-oriented Programming in Python')
  end

  it 'has the form item' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Add a CPD Activity')
  end

  it 'has the check marks' do
    expect(rendered).to have_css('.ncce-activity-list__item-check-mark', count: 2)
  end

end