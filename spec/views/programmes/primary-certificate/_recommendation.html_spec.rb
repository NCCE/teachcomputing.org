require 'rails_helper'

RSpec.describe('certificates/primary_certificate/_recommendation', type: :view) do
  it 'shows expected online course for lowest band' do
    render  partial: 'certificates/primary_certificate/recommendation',
            locals: {
              category: Activity::ONLINE_CATEGORY,
              diagnostic_result_percentage: 0
            }
    expect(rendered).to have_link('Teaching Programming in Primary Schools', href: 'https://www.futurelearn.com/courses/teaching-programming-primary-school')
  end

  it 'shows expected face to face course for lowest band' do
    render  partial: 'certificates/primary_certificate/recommendation',
            locals: {
              category: Activity::FACE_TO_FACE_CATEGORY,
              diagnostic_result_percentage: 30
            }
    expect(rendered).to have_link('Primary programming and algorithms', href: 'https://www.stem.org.uk/cpd/ondemand/445946/primary-programming-and-algorithms')
  end

  it 'shows expected online course for middle band' do
    render  partial: 'certificates/primary_certificate/recommendation',
            locals: {
              category: Activity::ONLINE_CATEGORY,
              diagnostic_result_percentage: 31
            }
    expect(rendered).to eq('')
  end

  it 'shows expected face to face course for middle band' do
    render  partial: 'certificates/primary_certificate/recommendation',
            locals: {
              category: Activity::FACE_TO_FACE_CATEGORY,
              diagnostic_result_percentage: 60
            }
    expect(rendered).to have_link('Teaching and leading key stage 1 computing', href: 'https://www.stem.org.uk/cpd/ondemand/445953/teaching-and-leading-key-stage-1-computing')
    expect(rendered).to have_link('Teaching and leading key stage 2 computing', href: 'https://www.stem.org.uk/cpd/ondemand/445949/teaching-and-leading-key-stage-2-computing')
  end

  it 'shows expected online course for highest band' do
    render  partial: 'certificates/primary_certificate/recommendation',
            locals: {
              category: Activity::ONLINE_CATEGORY,
              diagnostic_result_percentage: 61
            }
    expect(rendered).to have_link('Programming 101: An Introduction to Python for Educators', href: 'https://www.futurelearn.com/courses/programming-101')
    expect(rendered).to have_link('Scratch to Python: Moving from Block to Text based Programming', href: 'https://www.futurelearn.com/courses/block-to-text-based-programming')
  end

  it 'shows expected face to face course for highest band' do
    render  partial: 'certificates/primary_certificate/recommendation',
            locals: {
              category: Activity::FACE_TO_FACE_CATEGORY,
              diagnostic_result_percentage: 100
            }
    expect(rendered).to eq('')
  end
end
