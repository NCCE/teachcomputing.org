namespace :partners do
  desc "Checks organisation memberships for all course runs and attempts to add
  any membership ids we do not know about"
  task update_memberships: :environment do
    next if FeatureFlagService.new.ncce2_live

    FutureLearn::UpdateOrganisationMembershipsJob.perform_now
  end

  desc "Queues the job that will fetch course runs from the partners api and
  start the process of updating course progress for users"
  task update_progress: :environment do
    next if FeatureFlagService.new.ncce2_live

    FutureLearn::CourseRunsJob.perform_now
  end
end
