class Certificates::PathwaysController < ApplicationController
  before_action :set_pathway

  layout 'full-width'

  def show
    @programme = @pathway.programme
    @current_user = current_user

    recommended_activities = @pathway.pathway_activities.includes(:activity)
    @recommended_community_activities = recommended_activities.filter { |pa| pa.activity.category == :community.to_s }
    @recommended_community_activity_ids = @recommended_community_activities.map { _1.activity.id }
    @recommended_activities = recommended_activities - @recommended_community_activities

    @community_groups = @programme.programme_activity_groupings.community.order(:sort_key)
  end

  def set_pathway
    @pathway = Pathway.not_legacy.find_by!(slug: params[:slug])
  end
end
