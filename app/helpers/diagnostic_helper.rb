module DiagnosticHelper
  def current_position(steps, step)
    "Question #{steps.index(step) + 1} of #{steps.count}"
  end
end
