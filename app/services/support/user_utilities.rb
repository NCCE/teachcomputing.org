module Support
  class UserUtilities
    def self.sync(user_id)
      user = User.find(user_id)
      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
    end

    def self.reset_tests(user_id)
      user = User.find(user_id)
      user&.achievements&.each { |ach| ach.transition_to(:enrolled) }
    end
  end
end
