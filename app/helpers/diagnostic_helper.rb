module DiagnosticHelper
  def step_index(steps, step)
    steps.index(step) + 1
  end

  def current_position(steps, step)
    "Question #{step_index(steps, step)} of #{steps.count}"
  end
end
