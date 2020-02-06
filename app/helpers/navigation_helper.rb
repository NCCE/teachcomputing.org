module NavigationHelper
  def certificate_progress_for_user(user)
    return nil if user.programmes.empty?

    programme = user.programmes.first
    achieved_credits = programme.credits_achieved_for_certificate(current_user)
    max_credits = programme.max_credits_for_certificate

    link_to(programme_path(programme.slug), class: 'govuk-header__link ncce-header__navigation-certification-progress-bar-container') do
      "Your certificate <progress class='ncce-header__navigation-certification-progress-bar' aria-label='You have #{achieved_credits} out of #{max_credits} credits' value='#{achieved_credits}' max='#{max_credits}'></progress>".html_safe
    end
  end
end
