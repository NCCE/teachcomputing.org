require 'rails_helper'

RSpec.describe('programmes/primary-certificate/_recommendation', type: :view) do
  it 'shows correct online course for low score' do
    render  partial: 'programmes/primary-certificate/recommendation',
            locals: {
              category: Activity::ONLINE_CATEGORY,
              diagnostic_result: 5
            }
    expect(rendered).to have_css('.recommendation__text', text: /Teaching Programming in Primary Schools/)
  end

  it 'shows correct f2f course for low score' do
    render  partial: 'programmes/primary-certificate/recommendation',
            locals: {
              category: Activity::FACE_TO_FACE_CATEGORY,
              diagnostic_result: 5
            }
    expect(rendered).to have_css('.recommendation__text', text: /Primary programming and algorithms/)
  end

  it 'shows 2 f2f courses for low score' do
    render  partial: 'programmes/primary-certificate/recommendation',
            locals: {
              category: Activity::FACE_TO_FACE_CATEGORY,
              diagnostic_result: 15
            }
    expect(rendered).to have_css('.recommendation__text', count: 3)
  end

  it 'shows no online courses for low score' do
    render  partial: 'programmes/primary-certificate/recommendation',
            locals: {
              category: Activity::ONLINE_CATEGORY,
              diagnostic_result: 15
            }
    expect(rendered).to eq('')
  end

end
