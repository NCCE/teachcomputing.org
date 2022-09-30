module Support
  class UserUtilities
    def self.sync(user_id)
      user = User.find(user_id)
      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
    end
  end
end
