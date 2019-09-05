class DiagnosticPresenter < ActivityPresenter
  include Rails.application.routes.url_helpers
  include ActivitiesHelper

  def button_label(args = {})
    'Use the diagnostic tool'
  end

  def button_url(args = {})
    activities_redirect_path(Activity.diagnostic_tool.id, redirect: { url: class_marker_diagnostic_url(args[:current_user]) })
  end

  def completed_text(index)
    "Used the diagnostic tool"
  end

  def prompt_text(index)
    "Optionally, use the diagnostic tool"
  end

  def inspect
    super + "\n\DiagnosticPresenter - empty? #{empty?}\n\n"
  end
end
