# You should ensure that the relevant uploads have been added to
# - Digital summative assessment url
# on the /admin interface for Curriculum before trying to render this Preview.

class ExternalLinkCardComponentPreview < ViewComponent::Preview
  def default
    unit = CurriculumClient::Queries::Unit.one("unit-2", "key-stage-1")&.unit
    details = {title: "Digital Summative <br /> Assessment".html_safe, link: unit.digital_summative_assessment_url}

    render(ExternalLinkCardComponent.new(external_link_card: details))
  end
end
