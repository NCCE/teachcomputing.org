require "administrate/base_dashboard"

class BaseDashboard < Administrate::BaseDashboard
  FORMATTED_DATE_TIME = Field::DateTime.with_options(format: "%d/%m/%Y %H:%M")
  FORMATTED_DATE = Field::Date.with_options(format: "%d/%m/%Y")
end
