module CtaHelper
  def download_message_and_link
    download_message = 'Download your handbook'
    link_url = i_belong_handbook_url

    if current_user
      if Programme.i_belong.user_enrolled?(current_user)
        download_message = 'Download your handbook'
        link_url = i_belong_handbook_url
      else
        download_message = 'Enrol to download'
        link_url = dashboard_path
      end
    else
      download_message = 'Log in to download'
      link_url = login_path
    end

    { download_message: download_message, link_url: link_url }
  end
end