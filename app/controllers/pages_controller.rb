class PagesController < ApplicationController
  include CmsProcessing
  layout "full-width"
  before_action :redirect_to_dashboard, only: [:login]

  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def exception
    respond_to do |format|
      format.html { render template: "pages/exception", status: params[:status] }
      format.all { render plain: params[:status], status: params[:status] }
    end
  end

  def home
    process_resource(Cms::Singles::Homepage)
  end

  def non_gcse
    render template: "pages/enrolment/non_gcse"
  end

  def school_trusts
    render template: "pages/school_trusts"
  end

  def i_belong
    if current_user
      programme = Programme.i_belong
      session_state = programme.user_enrolled?(current_user) ? :enrolled : :unenrolled
      enrol_path = programme.enrol_path(user_programme_enrolment: {user_id: current_user.id, programme_id: programme.id})
    else
      session_state = :guest
      enrol_path = ""
    end

    case session_state
    when :enrolled
      posters_link_title = "Request your posters"
      posters_link = "https://forms.office.com/e/x1FMMzjxhg"
      posters_link_method = :get
      cta_link_path = i_belong_path
      cta_link_method = :get
      primary_handbook_download_url = helpers.i_belong_primary_handbook_url
      secondary_handbook_download_url = helpers.i_belong_secondary_handbook_url
      handbook_download_title = "Download your handbook"
    when :unenrolled
      posters_link_title = "Enrol to request"
      posters_link = enrol_path
      posters_link_method = :post
      cta_link_path = enrol_path
      cta_link_method = :post
      primary_handbook_download_url = dashboard_path
      secondary_handbook_download_url = dashboard_path
      handbook_download_title = "Enrol to download"
    else
      posters_link_title = "Log in to request"
      posters_link = helpers.auth_url
      posters_link_method = :post
      cta_link_path = helpers.auth_url
      cta_link_method = :post
      primary_handbook_download_url = login_path
      secondary_handbook_download_url = login_path
      handbook_download_title = "Log in to download"
    end

    render(
      template: "pages/enrolment/i_belong",
      locals: {session_state:,
               cta_link_path:,
               cta_link_method:,
               posters_link_title:,
               posters_link:,
               posters_link_method:,
               primary_handbook_download_url:,
               secondary_handbook_download_url:,
               handbook_download_title:}
    )
  end

  def isaac_computer_science
  end

  def login
    auth_uri = "/auth/stem"
    auth_uri += "?source_uri=#{params[:source_uri]}" if params[:source_uri].present?
    render template: "pages/login", locals: {auth_uri:}
  end

  # static programme pages except I Belong
  def static_programme_page
    @programme = Programme.find_by!(slug: params[:page_slug])
    redirect_to(@programme.path) and return if @programme.user_enrolled?(current_user)

    render template: "pages/enrolment/#{params[:page_slug].underscore}"
  end
end
