# frozen_string_literal: true

class Cms::MultiStateLinkComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(programme:, logged_out_link_title:, logged_out_link:, not_enrolled_link_title:, not_enrolled_link:, enrolled_link_title:, enrolled_link:)
    @programme = programme

    @logged_out_link_title = logged_out_link_title
    @logged_out_link = logged_out_link

    @not_enrolled_link_title = not_enrolled_link_title
    @not_enrolled_link = not_enrolled_link

    @enrolled_link_title = enrolled_link_title
    @enrolled_link = enrolled_link
  end

  def current_user_state
    return :logged_out unless current_user

    @programme.user_enrolled?(current_user) ? :enrolled : :not_enrolled
  end

  def call
    case current_user_state
    when :logged_out
      link_to(@logged_out_link_title, @logged_out_link, class: "ncce-link")
    when :not_enrolled
      link_to(@not_enrolled_link_title, @not_enrolled_link, class: "ncce-link")
    when :enrolled
      link_to(@enrolled_link_title, @enrolled_link, class: "ncce-link")
    end
  end
end
