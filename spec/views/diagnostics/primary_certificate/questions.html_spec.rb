require 'rails_helper'

RSpec.describe('diagnostics/primary_certificate/questions', type: :view) do
  let(:programme) { create(:programme, slug: 'primary-certificate') }

  before do
    stub_template 'diagnostics/_question' => "<div class='ncce-diagnostic__question'></div>"
    assign(:programme, programme)
    assign(:step, :question_1)
    assign(:steps, [:question_1])
    render
  end

  it 'would render the question partial' do
    expect(rendered).to have_css('.ncce-diagnostic__question')
  end

  it 'renders an aside' do
    expect(rendered).to have_css('.ncce-aside')
  end

  it 'has the expected class for hiding the aside on mobile devices' do
    expect(rendered).to have_css('.ncce-diagnostic__aside-question-1')
  end

  it 'renders the hero with the expected colour' do
    expect(rendered).to have_css('.hero--orange')
  end
end
