class PathwayImprovementsComponent < ViewComponent::Base
  attr_reader :pathway

  def initialize(pathway:)
    @pathway = pathway
  end

  def render?
    pathway.has_improvement_copy?
  end
end
