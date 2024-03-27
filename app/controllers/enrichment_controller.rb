class EnrichmentController < ApplicationController
  layout "full-width"

  helper_method :programme_t

  def show
    @programme = Programme.find_by!(slug: params[:slug])
    raise ActiveRecord::RecordNotFound unless @programme.enrichment_enabled?

    term_groupings = @programme
      .enrichment_groupings
      .includes(:enrichment_entries)
      .where(type: EnrichmentGroupings::Term.name)
      .sort_by(&:days_till_term)

    all_year_groupings = @programme
      .enrichment_groupings
      .where(type: EnrichmentGroupings::AllYear.name)

    @groupings = (term_groupings[0..0] || []) + all_year_groupings + (term_groupings[1..] || [])
  end

  private

  def programme_t(key, **options)
    I18n.t(".enrichment.show.#{@programme.slug}.#{key}", **options)
  end
end
