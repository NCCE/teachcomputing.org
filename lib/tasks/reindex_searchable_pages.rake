namespace :searchable_pages do
  desc "Reindexes the searchable pages"
  task reindex: :environment do
    SearchablePageIndexingJob.perform_now
  end
end
