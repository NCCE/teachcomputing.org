require 'rails_helper'

RSpec.describe Admin::ImportsController do
  let(:activity) { create(:activity, :future_learn) }
  let(:file) { Rack::Test::UploadedFile.new('spec/support/future_learn/imports/example_csv_export.csv') }

  describe 'POST #create' do
    context 'when cloudflare cookie is set' do
      before do
        activity
        allow_any_instance_of(described_class).to receive(:set_admin).and_return('user@example.com')
      end

      it 'renders the correct template and flash message' do
        post admin_imports_path, params: {
          provider: 'future-learn',
          triggered_by: 'user@example.com',
          csv_file: file
        }
        follow_redirect!
        expect(response.body).to include 'CSV Import has been scheduled'
      end

      it 'queues ProcessFutureLearnCsvExportJob job' do
        expect do
          post admin_imports_path, params: {
            provider: 'future-learn',
            triggered_by: 'user@example.com',
            csv_file: file
          }
        end.to have_enqueued_job(ProcessFutureLearnCsvExportJob)
      end
    end

    context 'when cloudflare cookie is not set' do
      it 'redirects to the index path' do
        post admin_imports_path, params: {
          provider: 'future-learn',
          triggered_by: 'user@example.com',
          csv_file: file
        }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
