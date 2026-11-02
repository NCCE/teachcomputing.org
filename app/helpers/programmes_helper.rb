module ProgrammesHelper
  def certificate_number(certificate_number, passed_date)
    "#{passed_date.strftime("%Y%m")}-#{format("%03d", certificate_number || 0)}"
  end

  def index_to_word_ordinal(index = 0)
    to_word_ordinal((index || 0) + 1)
  end

  def to_word_ordinal(number)
    index = number || 0
    ordinals = %w[none first second third fourth fifth sixth seventh eighth ninth tenth]
    return ordinals[index] if index <= ordinals.length && index.positive?

    ActiveSupport::Inflector.ordinalize(index)
  end

  def assessment_time(time)
    time.in_time_zone("London").strftime("%-l:%M%P on %A %-d %B %Y")
  end

  def attempt_count_in_words(count)
    {1 => "once", 2 => "twice"}.fetch(count) { "#{count} times" }
  end

  def eligible_for_secondary?(user)
    Programme.secondary_certificate.user_is_eligible?(user)
  end

  def csa_programme_title
    "KS3 and GCSE Computer Science subject knowledge"
  end

  def display_programme_tag(programme_slug)
    programme = Programme.find_by(slug: programme_slug)
    return programme.certificate_name if programme
    programme_slug.titlecase
  end

  def programme_pathway_card_data(programme, exclude: nil)
    pathways =
      if exclude.present?
        programme.pathways.not_legacy.where.not(id: exclude.id)
      else
        programme.pathways.not_legacy
      end

    pathways.map do |pathway|
      {
        title: pathway.title,
        text: pathway.description,
        button: :white,
        link: {
          link_url: pathway_path(pathway.slug),
          link_title: "Discover #{pathway.title.downcase} pathway"
        }
      }
    end
  end
end
