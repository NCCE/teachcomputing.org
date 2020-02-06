class WelcomeController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :user_enrolled?

  def show; end

  private

    def user_enrolled?
      cs_accelerator = Programme.cs_accelerator
      return redirect_to programme_path(cs_accelerator.slug) if cs_accelerator.user_enrolled?(current_user)

      primary_certificate = Programme.primary_certificate
      redirect_to programme_path(primary_certificate.slug) if primary_certificate.user_enrolled?(current_user)
    end
end
