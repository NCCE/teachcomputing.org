class SecondaryQuestionBanksComponentPreview < ViewComponent::Preview
  def with_bottom_margin
    render(SecondaryQuestionBanksComponent.new(
      text: "Use the links below to duplicate the forms into your own Google/Microsoft account. Once duplicated, they will be shareable with your students, with results only viewable by you.",
      bottom_margin: true
    ))
  end

  def no_bottom_margin
    render(SecondaryQuestionBanksComponent.new(
      text: "Use the links below to duplicate the forms into your own Google/Microsoft account. Once duplicated, they will be shareable with your students, with results only viewable by you.",
      bottom_margin: false
    ))
  end
end
