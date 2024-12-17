require "rails_helper"

RSpec.describe ExternalLinkHelper do
  %i[
    i_belong_primary_handbook_url
    i_belong_secondary_handbook_url
    i_belong_info_pack_url
    primary_mooncamp_webinar_url
    secondary_mooncamp_webinar_url
    primary_astro_pi_webinar_url
    secondary_astro_pi_webinar_url
    climate_detectives_webinar_url
    cyber_centurion_webinar_url
    secondary_stem_community_url
    primary_stem_community_url
    stem_community_points_help_url
    i_belong_poster_request_url
    isaac_posters_brochure_url
    stem_request_ambassador_url
    a_level_test_conditions_url
    do_your_bit_webinar_url
    tech_she_can_webinar_url
    into_film_webinar_url
    micro_bit_webinar_url
    stem_club_url
    apps_for_good_showcase_webinar_url
    cisco_cyber_camps_url
    digdata_webinar_url
    teen_tech_url
    arm_webinar_url
    first_lego_leauge_url
    cansat_webinar_url
    structuring_your_i_belong_evidence_url
    gcse_and_ks3_handbook_url
    i_belong_action_plan_url
    stem_ambassadors_url
    computing_ambassadors_url
    computing_quality_framework_url
    sme_support_form_url
    school_trusts_form_url
    hubs_local_support_form_url
    i_belong_student_survey_url
    primary_evidence_stem_community_url
    computing_quality_mark_url
    impact_toolkit_url
    leading_professional_development_url
    cas_communities_url
    social_media_card_templates_url
    gender_insights_in_computing_url
    ncce_student_events_url
    i_belong_press_release_pack_url
    stem_primary_ambassadors_url
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
