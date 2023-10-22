class ProgrammeDashboard::PrimaryAsidesComponent < ViewComponent::Base
  delegate :tracking_data, :tracking_category, :current_user, to: :helpers

  attr_reader :programme, :pathway, :available_pathways_for_user

  def initialize
    @programme = Programme.primary_certificate
  end

  def before_render
    @pathway = current_user.user_programme_enrolments.find_by(programme:).pathway
    @available_pathways_for_user = Pathway.ordered_by_programme(@programme.slug).not_legacy.where.not(id: pathway.id)
  end
end
