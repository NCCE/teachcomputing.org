# frozen_string_literal: true

class Cms::ProgrammeCardWrapperComponent < Cms::CardWrapperComponent
  def initialize(programme:, **)
    super(**)

    @programme = programme
  end

  def render?
    @programme
  end
end
