class CsChangesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
		@programme = Programme.cs_accelerator

		@online_achievements = current_user.achievements.for_programme(@programme).with_category(Activity::ONLINE_CATEGORY)

		@face_to_face_achievements = current_user.achievements.for_programme(@programme).with_category(Activity::FACE_TO_FACE_CATEGORY)

		render :show
 	end

end
