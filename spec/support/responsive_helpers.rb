module ResponsiveHelpers
  def resize_window_to_mobile
    resize_window_by([640, 320])
  end

  def resize_window_to_tablet
    resize_window_by([960, 641])
  end

  def resize_window_to_desktop
    resize_window_by([1024, 769])
  end

  private

    def resize_window_by(size)
      uses_selenium = Capybara.current_session.driver.browser.respond_to? 'manage'

      if uses_selenium
        Capybara.page.current_session.driver.browser.manage.resize_to(size[0], size[1])
      else
        Capybara.page.current_window.resize_to(size[0], size[1])
      end
    end
end
