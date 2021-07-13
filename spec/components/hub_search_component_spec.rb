require 'rails_helper'

RSpec.describe HubSearchComponent, type: :component do
  it 'shows location if present' do
    render_inline(described_class.new(location: 'sheffield'))
    expect(rendered_component).to include('sheffield')
  end

  it 'shows placeholder if no location' do
    render_inline(described_class.new(location: nil))
    expect(rendered_component).to include('Town, city or postcode')
  end
end
