require 'rails_helper'

RSpec.describe ExternalLinkHelper do
  %i[
      i_belong_handbook_url
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
  ].each do |external_link_method|
    describe "##{external_link_method}" do
      it 'should return a string' do
        expect(helper.public_send(external_link_method)).to be_a String
      end

      it 'should start with https' do
        expect(helper.public_send(external_link_method)).to start_with 'https'
      end
    end
  end
end
