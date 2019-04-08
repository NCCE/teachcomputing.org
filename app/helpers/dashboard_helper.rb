module DashboardHelper
  def has_downloaded_diagnostic?(achievements = [])
    achievements.any? { |a| a.activity.slug == 'downloaded-diagnostic-tool' }
  end
end
