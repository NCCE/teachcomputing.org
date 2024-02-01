class FeedbackController < ApplicationController
  def create
    feedback = FeedbackComment.new(feedback_params)
    feedback.user_id = current_user.id

    if feedback.save
      flash[:notice] = "Your feedback was successfully submitted"
    else
      flash[:error] = "There was a problem submitting feedback please try again"
    end
    redirect_to request.referer
  end

  private

  def feedback_params
    params.require(:feedback_comment).permit(:area, :comment)
  end
end
