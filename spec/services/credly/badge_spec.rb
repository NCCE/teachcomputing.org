require 'rails_helper'

RSpec.describe Credly::Badge do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:badge_template_id) { '00cd7d3b-baca-442b-bce5-f20666ed591b' }

  describe '#templates' do
    before do
      stub_badge_templates
    end

    it 'returns the required keys' do
      templates = described_class.templates

      %i[id name state recipient_type image
        created_at updated_at].each do |key|
      expect(templates.first.key?(key)).to eq(true)
      end
    end
  end

  describe '#issue' do
    context 'when the user exists' do
      before do
        user
        stub_issue_badge(user.id, badge_template_id)
      end

      it 'returns the required keys' do
        issue = described_class.issue(user.id, badge_template_id)

        %i[created_by user issuer badge_template].each do |key|
        expect(issue.key?(key)).to eq(true)
        end
      end
    end

    context 'when the user does not exist' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect do
          described_class.issue('123456789', badge_template_id)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#issued' do
    context 'when the user exists' do
      before do
        user
        stub_issued_badges(user.id)
      end

      it 'returns the required keys' do
        issued = described_class.issued(user.id)

        %i[issued_to issued_to_first_name badge_template].each do |key|
        expect(issued.first.key?(key)).to eq(true)
        end
      end
    end

    context 'when the user does not exist' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect do
          described_class.issued('123')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
