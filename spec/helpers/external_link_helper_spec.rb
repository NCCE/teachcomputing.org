require "rails_helper"

RSpec.describe ExternalLinkHelper do
  %i[
    i_belong_primary_handbook_url
    i_belong_secondary_handbook_url
    i_belong_info_pack_url
    stem_community_points_help_url
    i_belong_poster_request_url
    stem_request_ambassador_url
    a_level_test_conditions_url
    structuring_your_i_belong_evidence_url
    gcse_and_ks3_handbook_url
    i_belong_action_plan_url
    stem_ambassadors_url
    stem_secondary_ambassadors_url
    computing_ambassadors_url
    computing_quality_framework_url
    i_belong_student_survey_url
    primary_evidence_stem_community_url
    computing_quality_mark_url
    impact_toolkit_url
    leading_professional_development_url
    cas_communities_url
    social_media_card_templates_url
    ncce_student_events_url
    i_belong_press_release_pack_url
    isaac_url
    isaac_journey_gallery_url
    isaac_journey_careers_url
    i_am_computer_scientist_url
    ncce_eventbrite_url
    local_hub_professional_development_form_url
    secondary_certificate_evidence_guide_url
  ].each do |external_link_method|
    describe "##{external_link_method}" do
      it "should return a string" do
        expect(helper.public_send(external_link_method)).to be_a String
      end

      it "should start with https" do
        expect(helper.public_send(external_link_method)).to start_with "https"
      end
    end
  end
end
