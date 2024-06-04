# You should ensure that the relevant uploads have been added to
# - Unit Guide
# - Learning Graph
# - Rubrics
# - Summative assessments
# - Summative answers
# - Digital summative assessment url
# on the /admin interface for Curriculum before trying to render this Preview.

class MixedCardsComponentPreview < ViewComponent::Preview
  def default
    unit = CurriculumClient::Queries::Unit.one("unit-2", "key-stage-1")&.unit

    cards = [{type: :file, details: unit.unit_guide}] +
      (unit.learning_graphs + unit.rubrics + unit.summative_assessments + unit.summative_answers).map { {type: :file, details: _1} } +
      [{type: :external_link, details: {title: "Digital Summative <br /> Assessment".html_safe, link: unit.digital_summative_assessment_url}}]

    render(MixedCardsComponent.new(cards: cards))
  end
end
