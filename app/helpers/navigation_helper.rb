module NavigationHelper
  def certificate_progress_for_user(user)
    return nil if user.programmes.empty?

    programme = user.programmes.first
    achieved_credits = programme.credits_achieved_for_certificate(user)
    max_credits = programme.max_credits_for_certificate

    link_to(programme.path, class: 'govuk-header__link ncce-header__navigation-certification-progress-bar-container') do
      "Your certificate <progress class='ncce-header__navigation-certification-progress-bar' aria-label='You have #{achieved_credits} out of #{max_credits} credits' value='#{achieved_credits}' max='#{max_credits}'></progress>".html_safe
    end
  end

  def certificate_progress_for_user_cs_accelerator(user)
		programme = user.programmes.cs_accelerator

  	if programme.nil?
			"<span class='ncce-header__navigation-certification-progress-bar' aria-label='Not yet progress'></span>".html_safe
		else
			programme = user.programmes.cs_accelerator
			achieved_credits = programme.credits_achieved_for_certificate(user)
			max_credits = programme.max_credits_for_certificate

			link_to(programme.path, class: 'govuk-header__link ncce-header__navigation-certification-progress-bar-container') do
				"<progress class='ncce-header__navigation-certification-progress-bar' aria-label='You have #{achieved_credits} out of #{max_credits} credits' value='#{achieved_credits}' max='#{max_credits}'></progress>".html_safe
    	end
		end
  end

  def certificate_progress_for_user_primary(user)
    return nil if user.programmes.primary_certificate.nil?

    programme = user.programmes.primary_certificate
    achieved_credits = programme.credits_achieved_for_certificate(user)
    max_credits = programme.max_credits_for_certificate

    link_to(programme.path, class: 'govuk-header__link ncce-header__navigation-certification-progress-bar-container') do
      "<progress class='ncce-header__navigation-certification-progress-bar' aria-label='You have #{achieved_credits} out of #{max_credits} credits' value='#{achieved_credits}' max='#{max_credits}'></progress>".html_safe
    end
  end
end
