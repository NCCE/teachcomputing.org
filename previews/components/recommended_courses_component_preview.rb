# frozen_string_literal: true

class RecommendedCoursesComponentPreview < ViewComponent::Preview
  def default
    render component(pathway:)
  end

  def start_collapsed
    render component(pathway:, start_expanded: false)
  end

  def with_description
    render component(pathway:) do |c|
      c.with_description { "Your pathway (PDF)" }
    end
  end

  def with_two_courses
    render component(pathway:, recommended_activities: pathway.recommended_activities.first(2))
  end

  def without_pathway
    render component(pathway: nil, recommended_activities: nil, programme: Programme.cs_accelerator)
  end

  private

  def component(pathway:, programme: pathway.programme, recommended_activities: pathway.recommended_activities, **)
    RecommendedCoursesComponent.new(
      current_user: User.first.presence || FactoryBot.create(:user),
      programme:,
      pathway:,
      recommended_activities:,
      event_category: "preview",
      **
    )
  end

  def pathway
    @pathway ||= Pathway.joins(:pathway_activities)
      .group("pathways.id")
      .having("COUNT(pathway_activities.id) > ?", RecommendedCoursesComponent::VISIBLE_COUNT)
      .first || create_pathway
  end

  def create_pathway
    FactoryBot.create(:pathway).tap do |pathway|
      FactoryBot.create_list(:pathway_activity, 4, pathway:)
    end
  end
end
