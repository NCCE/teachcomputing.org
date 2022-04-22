require 'rails_helper'

RSpec.describe('pages/impact-and-evaluation', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Impact, evaluation and research')
  end

  it 'has an introduction' do
    expect(rendered).to have_css('.govuk-body-l',
                                 text: 'Our vision is for every child in every school in England to have a world-leading computing education.')
  end

  context 'with the related links section' do
    it 'has a title' do
      expect(rendered).to have_css('.govuk-heading-s', text: 'Related links')
    end

    it 'has the expected links' do
      expect(rendered).to have_link('About us', href: '/about')
    end
  end

  context 'with the evaluation reports section' do
    it 'has a title' do
      expect(rendered).to have_css('.govuk-heading-l', text: 'Impact and evaluation reports')
    end

    it 'has the expected links' do
      expect(rendered).to have_link('View NCCE Impact Report', href: 'https://static.teachcomputing.org/NCCE_Impact_Report_Final.pdf')
      expect(rendered).to have_link('Computer Science Accelerator Graduates Evaluation (cohort 1)', href: 'https://static.teachcomputing.org/Computer_Science_Accelerator_Cohort.pdf')
    end
  end

  context 'with the curriculum reports section' do
    it 'has a title' do
      expect(rendered).to have_css('.govuk-heading-l', text: 'Research and curriculum reports')
    end

    it 'has the expected links' do
      expect(rendered).to have_link('View Programming and Algorithms Report', href: 'https://static.teachcomputing.org/Programming+and+Algorithms+Report.pdf')
      expect(rendered).to have_link('Computer Systems and Networks report', href: 'https://static.teachcomputing.org/Computer_Systems_%26_Networking_Report_-_Final.pdf')
      expect(rendered).to have_link('Digital Literacy Report', href: 'https://raspberrypi-education.s3-eu-west-1.amazonaws.com/NCCE+Reports/Digital+Literacy+Within+the+Computing+Curriculum+(Final).pdf')
      expect(rendered).to have_link('International Computing Textbook Review', href: 'https://static.teachcomputing.org/International_Textbook_Review.pdf')
      expect(rendered).to have_link('Practical programming white paper', href: 'https://static.teachcomputing.org/Practical+Work+in+Computing+Apr+22.pdf')
    end
  end

  context 'with the research resources section' do
    it 'has a title' do
      expect(rendered).to have_css('.govuk-heading-l', text: 'Our research resources')
    end

    it 'has the expected links' do
      expect(rendered).to have_link('Take part in our research', href: '/gender-balance')
      expect(rendered).to have_link('Meet our panels', href: '/subject-practitioners')
      expect(rendered).to have_link('Pedagogy resources', href: '/pedagogy')
    end
  end

  context 'with the other resources section' do
    it 'has a title' do
      expect(rendered).to have_css('.govuk-heading-l', text: 'You might also be interested in')
    end

    it 'has an introduction' do
      expect(rendered).to have_css('.govuk-body-m',
                                   text: 'Our consortium partners have additional content around impact, evaluation and research you may find valuable.')
    end

    it 'has the expected links' do
      expect(rendered).to have_link('Impact and evaluation', href: 'https://www.stem.org.uk/impact-and-evaluation')
      expect(rendered).to have_link('Computing education research seminars', href: 'https://www.raspberrypi.org/computing-education-research-online-seminars/')
      expect(rendered).to have_link('Academic publications', href: 'https://www.bcs.org/more/learned-publishing/')
    end
  end
end
