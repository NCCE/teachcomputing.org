class SearchesController < ApplicationController
  layout 'full-width'

  helper_method :sort_options

  def show
    @query = params[:q]

    @results = SiteSearch.search(@query, order: sort_symbol)

    @pagy, @paged_results = pagy(@results)
  end

  private

  def sort_symbol
    if params[:order].in? ['published_newest', 'published_oldest']
      params[:order].to_sym
    else
      nil
    end
  end

  def sort_options
    return @sort_options if @sort_options.present?

    @sort_options = {
      'default' => 'Relevance',
      'published_newest' => 'Newest First',
      'published_oldest' => 'Oldest First'
    }

    if params[:order].in? @sort_options.keys
      @sort_options = {
        params[:order] => @sort_options[params[:order]],
        **@sort_options.excluding(params[:order]),
      }
    end

    @sort_options
  end
end
