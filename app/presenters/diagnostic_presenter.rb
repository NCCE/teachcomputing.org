class DiagnosticPresenter < AchievementPresenter
  include Rails.application.routes.url_helpers
  include ActivitiesHelper

  def button_label(*)
    'Use the diagnostic tool'
  end

  def button_url(*)
    diagnostic_cs_accelerator_certificate_path(Activity.cs_accelerator_diagnostic_tool.id)
  end

  def completed_text(*)
    'Used the diagnostic tool'
  end

  def prompt_text(*)
    'Use the diagnostic tool'
  end

  def inspect
    "DiagnosticPresenter - empty? #{empty?}\n" + super
  end
end
