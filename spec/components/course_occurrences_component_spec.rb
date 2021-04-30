require 'rails_helper'

RSpec.describe CourseOccurrencesComponent, type: :component do
  it 'does not render if there are no occurrences' do
    render_inline(described_class.new(occurrences: []))
    expect(rendered_component).to eq('')
  end
end
