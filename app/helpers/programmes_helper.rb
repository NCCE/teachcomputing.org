module ProgrammesHelper

  def certificate_number(certificate_number, passed_date)
    "#{passed_date.strftime('%Y%m')}-#{sprintf('%03d', certificate_number || 0)}"
  end

  def to_word_ordinal(number)
    index = number || 0;
    ordinals = %w[none first second third fourth fifth sixth seventh eighth ninth tenth]
    return ordinals[index] if index <= ordinals.length && index > 0
    ActiveSupport::Inflector::ordinalize(index)
  end

  def can_take_accelerator_test?(user, programme)
    credits_for_programme(user, programme) { |total| return total >= 80 }
  end

  def credits_for_programme(user, programme)
    total = 0
    programme.credits_for_certificate.each do |category, threshold|
      total += [_credits_for_courses(user, programme, category), threshold].min
    end
    yield total
  end

  private
    def _credits_for_courses(user, programme, category = 'online')
      activities = user.achievements.for_programme(programme).in_state('complete').joins(:activity)
      activities.where(activities: { category: category}).sum(:credit)
    end
end
