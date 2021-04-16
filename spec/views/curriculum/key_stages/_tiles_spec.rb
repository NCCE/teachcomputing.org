require 'rails_helper'

RSpec.describe('curriculum/key_stages/_tiles', type: :view) do
  let(:key_stage_json) { File.new('spec/support/curriculum/views/key_stage.json').read }

  before do
    key_stage = JSON.parse(key_stage_json, object_class: OpenStruct).data.key_stage
    render partial: 'tiles', locals: { key_stage: key_stage }
  end

  it 'shows the expected curriculum maps' do
    expect(rendered).to have_link('Map 1', href: 'something.somewhere')
    expect(rendered).to have_link('Map 2', href: 'something_else.somewhere_else')
  end

  it 'shows the expected teacher guide' do
    expect(rendered).to have_link('Teacher guide', href: "https://teachcomputing.org")
  end
end
