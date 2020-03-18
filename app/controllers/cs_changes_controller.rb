class CsChangesController < ApplicationController
  layout 'full-width'

  def show
		@programme = Programme.find_by!(slug: params[:page_slug])
		render: show
 	end

end
