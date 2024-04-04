module ResponsiveHelpers
  def resize_window_to_mobile
    resize_window_by([375, 667]) # iPhone SE
  end

  def resize_window_to_tablet
    resize_window_by([810, 1080]) # iPad
  end

  def resize_window_to_desktop
    resize_window_by([1280, 800]) # Laptop with MDPI
  end

  private

  def resize_window_by(size)
    return unless Capybara.current_session.driver.browser.respond_to? :manage

    Capybara.current_session.driver.browser.manage.window.resize_to(size[0], size[1])
  end
end
