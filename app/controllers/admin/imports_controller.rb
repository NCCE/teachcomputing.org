class Admin::ImportsController < ApplicationController
  before_action :set_activity, only: %i[new create]

  def new; end

  def create
    import = Import.new(activity_id: params[:activity_id],
                        provider: params[:provider],
                        triggered_by: 'Damien')
    if import.save
      ProcessFutureLearnCsvExportJob.perform_later(@activity, params[:csv_file].read.to_s, import)
      flash[:notice] = "CSV Import for #{@activity.title} has been scheduled"
    else
      flash[:error] = import.errors.inspect.to_s
    end
    redirect_to admin_imports_path
  end

  private

  def set_activity
    @activity = Activity.find_by(id: params[:activity_id])
  end
end
