class Certificates::PathwaysController < ApplicationController
  before_action :set_pathway

  layout 'full-width'

  def show
    @programme = @pathway.programme
    @current_user = current_user

    recommended_activities = @pathway.pathway_activities.includes(:activity)
    @recommended_community_activities = recommended_activities.filter { |pa| pa.activity.category == :community.to_s }
    @recommended_activities = recommended_activities - @recommended_community_activities

    # FUTURE: we should talk about how we want to organise activity groupings.
    @community_groups = @programme.programme_activity_groupings.where(sort_key: 4...).order(:sort_key)

    @other_pathways = @programme.pathways.where.not(id: @programme.id).sample(3)
  end

  def set_pathway
    @pathway = Pathway.find_by!(slug: params[:slug])
  end
end
