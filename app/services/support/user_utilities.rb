module Support
  class UserUtilities
    def self.sync(user_id)
      user = User.find(user_id)
      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
    end

    def self.reset_tests(user_id)
      user = User.find(user_id)
      user&.assessment_attempts&.destroy_all
    end
  end
end
