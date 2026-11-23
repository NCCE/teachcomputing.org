module ProgrammesHelper
  def certificate_number(certificate_number, passed_date)
    "#{passed_date.strftime("%Y%m")}-#{format("%03d", certificate_number || 0)}"
  end

  def assessment_time(time)
    time.in_time_zone("London").strftime("%-l:%M%P on %A %-d %B %Y")
  end

  def assessment_date(time)
    time.in_time_zone("London").strftime("%-d %B %Y")
  end

  def attempt_count_in_words(count)
    {1 => "once", 2 => "twice"}.fetch(count) { "#{count} times" }
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
