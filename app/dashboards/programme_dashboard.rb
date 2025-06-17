require "administrate/custom_dashboard"

class ProgrammeDashboard < Administrate::CustomDashboard
  resource "Programmes"

  def display_resource(programme)
    programme.title
  end
end
