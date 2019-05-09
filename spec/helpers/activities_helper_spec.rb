require 'rails_helper'

describe ActivitiesHelper, type: :helper do
  let(:user) { create(:user) }

  describe('#class_marker_diagnostic_url') do
    it 'returns a url with the user id and email address' do
      url = ENV.fetch('CLASS_MARKER_DIAGNOSTIC_URL').to_s + "&cm_e=#{user.email}&cm_user_id=#{user.id}"
      expect(helper.class_marker_diagnostic_url(user)).to eq url
    end
  end
end
