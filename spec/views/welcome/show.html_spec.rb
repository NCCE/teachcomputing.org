require 'rails_helper'

RSpec.describe('welcome/show', type: :view) do
  let(:user) { create(:user) }
  # let(:cs_accelerator) { create(:cs_accelerator) }
  # let(:primary_certificate) { create(:primary_certificate) }
  # let(:user_programme_enrolment) do
  #   create(:user_programme_enrolment,
  #          user_id: user.id,
  #          programme_id: cs_accelerator.id)
  # end

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: 'Welcome to Teach Computing')
  end

  it 'has the cs_accelerator card' do
    expect(rendered).to have_css('.card__heading', text: 'Teach GCSE computer science')
  end

  it 'has the primary certificate card' do
    expect(rendered).to have_css('.card__heading', text: 'Teach primary computing')
  end

  # context 'when the user has enrolled on a programme' do
  #   before do
  #     user_programme_enrolment
  #     user.reload
  #     render
  #   end
  # end

end
