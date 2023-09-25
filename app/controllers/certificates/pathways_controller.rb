class Certificates::PathwaysController < ApplicationController
  before_action :set_pathway

  layout 'full-width'

  def show
    @programme = @pathway.programme
    @current_user = current_user

    @recommended_community_activity_ids = @pathway.pathway_activities.distinct.joins(:activity).where(activity: { category: :community }).pluck(:id)
    @recommended_activities = @pathway.pathway_activities.includes(:activity).where.not(activity: { category: :community })

    @cpd_group = @programme.programme_activity_groupings.not_community.first
    @community_groups = @programme.programme_activity_groupings.community.order(:sort_key)
  end

  def set_pathway
    @pathway = Pathway.not_legacy.find_by!(slug: params[:slug])
  end
end
