class ScheduleProgrammeGettingStartedPromptJob < ApplicationJob
  queue_as :default

  def perform(user_id, programme_id)
    user = User.find(user_id)
    programme = Programme.find(programme_id)

    return if user.achievements.for_programme(programme).count.positive?

    ProgrammeProgressMailer.with(user: user, slug: programme.slug).get_started_prompt.deliver_now
  end
end
