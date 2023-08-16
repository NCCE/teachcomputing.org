class EnrichmentController < ApplicationController
  layout 'full-width'

  helper_method :programme_t

  def show
    @programme = Programme.includes(enrichment_groupings: :enrichment_entries).find_by!(slug: params[:slug])
    raise ActiveRecord::RecordNotFound unless @programme.enrichment_enabled?
  end

  private

    def programme_t(key)
      I18n.t(".enrichment.show.#{@programme.slug}.#{key}")
    end
end
