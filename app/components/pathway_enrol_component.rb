class PathwayEnrolComponent < ViewComponent::Base
  attr_reader :programme, :pathway, :current_user

  delegate :create_account_url, to: :helpers

  def initialize(programme:, pathway:, current_user: nil)
    @programme = programme
    @pathway = pathway
    @current_user = current_user
  end

  def render?
    !current_user&.enrolled_on_programme_pathway?(programme:, pathway:)
  end
end
