module UserHelper
  def administrate?
    current_page?(admin_path)
  end
end
