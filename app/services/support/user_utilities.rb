module Support
  class UserUtilities
    def self.sync(user_id)
      user = User.find(user_id)
      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
    end

    def self.reset_tests(user_id)
      AssessmentAttempt.where(user_id:).destroy_all
      SupportAudit.where(user_id:).last
    end
  end
end
