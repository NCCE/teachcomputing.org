module ProgrammesHelper

  def certificate_number(certificate_number, passed_date)
    "#{passed_date.strftime('%Y%m')}-#{sprintf('%03d', certificate_number || 0)}"
  end

  def index_to_word_ordinal(index = 0)
    to_word_ordinal((index || 0) + 1)
  end

  def to_word_ordinal(number)
    index = number || 0;
    ordinals = %w[none first second third fourth fifth sixth seventh eighth ninth tenth]
    return ordinals[index] if index <= ordinals.length && index > 0
    ActiveSupport::Inflector::ordinalize(index)
  end

  def eligible_for_secondary?(user)
    Programme.secondary_certificate.user_is_eligible?(user)
  end

  def user_certificate_progress(user, programme)
		enrolled = user.programmes.include?(programme)

  	if enrolled
			achieved_credits = programme.credits_achieved_for_certificate(user)
			max_credits = programme.max_credits_for_certificate

			link_to(programme.path, class: 'govuk-header__link ncce-header__navigation-certification-progress-bar-container') do
				"<progress class='ncce-header__navigation-certification-progress-bar' aria-label='You have #{achieved_credits} out of #{max_credits} credits' value='#{achieved_credits}' max='#{max_credits}'></progress>".html_safe
			end
		else
			"<span aria-label='Enrol to a programme and track your progress'></span>".html_safe
		end
  end
end
