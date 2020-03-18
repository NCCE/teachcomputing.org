class CsChangesController < ApplicationController
  layout 'full-width'

  def show
		@programme = Programme.cs_accelerator
		render :show
 	end

end
