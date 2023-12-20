require 'rails_helper'

RSpec.describe Certificates::PathwaysController do
  let(:programme) { create(:programme) }
  let(:cpd_group) { create(:programme_activity_grouping, community: false, programme:) }
  let(:pathway) { create(:pathway, programme:, enrol_copy: ['foo', 'bar']) }

  describe 'GET #show' do
    before do
      cpd_group
      get pathway_path(slug: pathway.slug)
    end

    it 'shows the page' do
      expect(response).to render_template('certificates/pathways/show')
    end
  end
end
