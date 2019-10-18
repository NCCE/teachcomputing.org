module DiagnosticHelper
  def current_position(steps, current_step)
    "Question #{steps.index(current_step) + 1} of #{steps.count}"
  end
end
