module ImportsHelper
  def completed_at?(import)
    return 'Import pending' if import.completed_at.nil?
    import.completed_at.to_formatted_s(:short)
  end
end
