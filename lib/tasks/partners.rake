namespace :partners do
  desc "Queues the job that will fetch course runs from the partners api and
  start the process of updating course progress for users"
  task fetch_runs: :environment do
    FutureLearn::CourseRunsJob.perform_now
  end
end
