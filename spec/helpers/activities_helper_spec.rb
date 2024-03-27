require "rails_helper"

describe ActivitiesHelper do
  let(:user) { create(:user) }

  describe("#class_marker_diagnostic_url") do
    it "returns a url with the user id and email address" do
      url = ENV.fetch("CLASS_MARKER_DIAGNOSTIC_URL").to_s + "&cm_e=#{user.email}&cm_user_id=#{user.id}"
      expect(helper.class_marker_diagnostic_url(user)).to eq url
    end
  end

  describe ".activity_type" do
    it 'returns "Online" for online course' do
      activity = create(:activity, category: Activity::ONLINE_CATEGORY)
      expect(helper.activity_type(activity)).to eq("Online")
    end

    it 'returns "Face to Face" for face to face course' do
      activity = create(:activity, category: Activity::FACE_TO_FACE_CATEGORY)
      expect(helper.activity_type(activity)).to eq("Face to face")
    end

    it 'returns "Remote" for remote course' do
      activity = create(:activity, category: Activity::FACE_TO_FACE_CATEGORY, remote_delivered_cpd: true)
      expect(helper.activity_type(activity)).to eq("Remote")
    end
  end

  describe ".activity_icon_class" do
    it 'returns "icon-online" for online course' do
      activity = create(:activity, category: Activity::ONLINE_CATEGORY)
      expect(helper.activity_icon_class(activity))
        .to eq("icon-online")
    end

    it 'returns "icon-map-pin" for face to face course' do
      activity = create(:activity, category: Activity::FACE_TO_FACE_CATEGORY)
      expect(helper.activity_icon_class(activity))
        .to eq("icon-map-pin")
    end

    it 'returns "icon-remote" for remote course' do
      activity = create(:activity, category: Activity::FACE_TO_FACE_CATEGORY, remote_delivered_cpd: true)
      expect(helper.activity_icon_class(activity))
        .to eq("icon-remote")
    end
  end
end
