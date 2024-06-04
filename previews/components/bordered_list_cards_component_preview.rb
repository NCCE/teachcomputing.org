class BorderedListCardsComponentPreview < ViewComponent::Preview
  def one_card_per_row
    render_card(cards_per_row: 1)
  end

  def two_cards_per_row
    render_card(cards_per_row: 2)
  end

  def three_cards_per_row
    render_card(cards_per_row: 3)
  end

  private

  def render_card(cards_per_row:)
    render(BorderedListCardsComponent.new(**GetInvolved.other_ways_to_get_involved_cards, cards_per_row:))
  end
end
