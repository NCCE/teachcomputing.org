class Admin::ImportsController < ApplicationController
  before_action :set_admin, only: %i[new create]

  def index
    @imports = Import.all
  end

  def new; end

  def create
    import = Import.new(provider: params[:provider],
                        triggered_by: params[:triggered_by])
    if import.save
      ProcessFutureLearnCsvExportJob.perform_later(params[:csv_file].read.force_encoding(Encoding::UTF_8).to_s, import)
      flash[:notice] = 'CSV Import has been scheduled'
    else
      flash[:error] = 'Whoops something went wrong'
    end
    redirect_to admin_imports_path
  end

  private

  def set_admin
    if cookies[:CF_Authorization].nil?
      flash[:error] = 'Whoops something went wrong'
      redirect_to root_path
    else
      decoded_token = decode_cookie(cookies[:CF_Authorization])
      @admin_email = decoded_token.first['email']
    end
  end

  def decode_cookie(token)
    JWT.decode token, nil, false
  end
end
