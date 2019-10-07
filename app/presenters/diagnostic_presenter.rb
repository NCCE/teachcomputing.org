class DiagnosticPresenter < ActivityPresenter
  include Rails.application.routes.url_helpers
  include ActivitiesHelper

  def button_label(*)
    'Use the diagnostic tool'
  end

  def button_url(args = {})
    cs_accelerator_diagnostic_path(Activity.cs_accelerator_diagnostic_tool.id, redirect: { url: class_marker_diagnostic_url(args[:current_user]) })
  end

  def completed_text(*)
    'Used the diagnostic tool'
  end

  def prompt_text(*)
    'Optionally, use the diagnostic tool'
  end

  def inspect
    "DiagnosticPresenter - empty? #{empty?}\n" + super
  end
end
