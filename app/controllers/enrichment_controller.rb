class EnrichmentController < ApplicationController
  layout 'full-width'

  helper_method :programme_t

  def show
    @programme = Programme.includes(enrichment_groupings: :enrichment_entries).find_by!(slug: params[:slug])
    raise ActiveRecord::RecordNotFound unless @programme.enrichment_enabled?

    term_groupings = @programme.enrichment_groupings.where(type: EnrichmentGroupings::Term.name, coming_soon: false).sort_by(&:days_till_term)
    all_year_groupings = @programme.enrichment_groupings.where(type: EnrichmentGroupings::AllYear.name, coming_soon: false)
    coming_soon_groupings = @programme.enrichment_groupings.where(coming_soon: true)

    @groupings = term_groupings + all_year_groupings + coming_soon_groupings
  end

  private

    def programme_t(key, **options)
      I18n.t(".enrichment.show.#{@programme.slug}.#{key}", **options)
    end
end
