require 'rails_helper'

RSpec.describe 'rake searchable_pages:reindex', type: :task do
  it 'should call SearchablePageIndexingJob.perform_now' do
    expect(SearchablePageIndexingJob).to receive(:perform_now)

    task.execute
  end
end
