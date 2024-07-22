require "rails_helper"

RSpec.describe Activity, type: :model do
  let(:activity) { create(:activity) }
  let(:online_activity) { create(:activity, :future_learn) }
  let(:face_to_face_activity) { create(:activity, :face_to_face) }
  let(:future_learn_courses) { create_list(:activity, 3, :future_learn) }
  let(:my_learning_courses) { create_list(:activity, 3, :my_learning) }
  let(:online_courses) { future_learn_courses + my_learning_courses }
  let(:face_to_face_courses) { create_list(:activity, 3, :stem_learning) }
  let(:community_activity) { create(:activity, :community) }
  let(:system_activity) { create_list(:activity, 3, :system) }
  let(:user) { create(:user) }
  let(:user_achievement) { create(:achievement, user_id: user.id, activity_id: online_activity.id) }
  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:removable_activity) { create(:activity, :user_removable) }

  describe "associations" do
    it "has_one assessment" do
      expect(activity).to have_one(:assessment)
    end

    it "has_many pathway_activities" do
      expect(activity).to have_many(:pathway_activities)
    end

    it "has_many achievements" do
      expect(activity).to have_many(:achievements)
    end

    it "has_many users" do
      expect(activity).to have_many(:users).through(:achievements)
    end

    it "has_many programmes" do
      expect(activity).to have_many(:programmes).through(:programme_activities)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_inclusion_of(:category).in_array(%w[action online face-to-face]) }
    it { is_expected.to validate_uniqueness_of(:future_learn_course_uuid) }
    it { is_expected.to validate_uniqueness_of(:stem_activity_code) }
    it { is_expected.to validate_uniqueness_of(:stem_course_template_no).case_insensitive }
  end

  describe "scopes" do
    describe "available_for" do
      before do
        [online_activity, online_courses, user, user_achievement]
      end

      it "lists available online activities for a given user" do
        expect(described_class.available_for(user)).to match_array(online_courses)
      end

      it "does not include activities if a user already has an existing achievement" do
        expect(described_class.available_for(user)).not_to include(online_activity)
      end
    end

    describe "online" do
      before do
        [online_courses, face_to_face_courses]
      end

      it "includes only online activities" do
        expect(described_class.online).to match_array(online_courses)
      end

      it "does not include face-to-face courses" do
        expect(described_class.online).not_to include(face_to_face_courses.first)
      end
    end

    describe "face_to_face" do
      before do
        [face_to_face_courses, online_courses]
      end

      it "includes only face-to-face activities" do
        expect(Activity.face_to_face).to match_array(face_to_face_courses)
      end

      it "does not include online courses" do
        expect(Activity.face_to_face).not_to include(online_courses.first)
      end
    end

    describe "future_learn" do
      before do
        [future_learn_courses, my_learning_courses, activity]
      end

      it "includes only future-learn activities" do
        expect(Activity.future_learn).to match_array(future_learn_courses)
      end

      it "does not include actions" do
        expect(Activity.future_learn).not_to include(activity)
      end
    end

    describe "my_learning" do
      before do
        [future_learn_courses, my_learning_courses, activity]
      end

      it "includes only MyLearning activities" do
        expect(Activity.my_learning).to match_array(my_learning_courses)
      end

      it "does not include actions" do
        expect(Activity.my_learning).not_to include(activity)
      end

      it "does not include FutureLearn courses" do
        expect(Activity.my_learning).not_to include(future_learn_courses.first)
      end

      it "does not include face-to-face courses" do
        expect(Activity.my_learning).not_to include(face_to_face_courses.first)
      end
    end

    describe "stem-learning" do
      before do
        [face_to_face_courses, online_courses]
      end

      it "includes only stem-learning activities" do
        expect(described_class.stem_learning).to match_array(face_to_face_courses + my_learning_courses)
      end

      it "does not include future-learn courses" do
        expect(described_class.stem_learning).not_to include(future_learn_courses.first)
      end

      it "should downcase stem_course_template_no" do
        new_activity = create(:activity, stem_course_template_no: "81CBA5BF-4C66-4FA7-8595-9124925106DD")
        expect(new_activity.stem_course_template_no).to eq("81cba5bf-4c66-4fa7-8595-9124925106dd")
      end
    end

    describe "community" do
      before do
        [community_activity, online_courses]
      end

      it "includes only community activities" do
        expect(described_class.community.to_a).to include(community_activity)
      end

      it "does not include actions" do
        expect(described_class.community).not_to include(online_courses.first)
      end
    end

    describe "system" do
      before do
        [system_activity, activity]
      end

      it "includes only system activities" do
        expect(described_class.system).to match_array(system_activity)
      end

      it "does not include actions" do
        expect(described_class.system).not_to include(activity)
      end
    end

    describe "user_removable" do
      before do
        [removable_activity, activity, diagnostic_tool_activity]
      end

      it "include future-learn activities" do
        expect(described_class.user_removable).to include(removable_activity)
      end

      it "does not include stem" do
        expect(described_class.user_removable).not_to include(activity)
      end

      it "does not include diagnostic download" do
        expect(described_class.user_removable).not_to include(diagnostic_tool_activity)
      end
    end
  end

  describe ".cs_accelerator_diagnostic_tool" do
    it "returns a record if one is found" do
      activity = create(:activity, :cs_accelerator_diagnostic_tool)
      expect(described_class.cs_accelerator_diagnostic_tool).to eq activity
    end

    it "creates a record if one is not found" do
      expect(described_class.cs_accelerator_diagnostic_tool.title).to eq "Taken diagnostic tool"
    end
  end

  describe "#online?" do
    it 'returns true when category is "online"' do
      activity = build(:activity, category: described_class::ONLINE_CATEGORY)
      expect(activity.online?).to eq(true)
    end

    it "returns false when category is something else" do
      activity = build(:activity, category: described_class::FACE_TO_FACE_CATEGORY)
      expect(activity.online?).to eq(false)
    end
  end

  describe "#active_course?" do
    it "returns true when stem acitivity code present and not retired courses" do
      activity = build(:activity)
      expect(activity.active_course?).to eq(true)
    end

    it "returns false when course activity marked as retired" do
      activity = build(:activity, retired: true)
      expect(activity.active_course?).to eq(false)
    end

    it "returns false when the course stem acitivity code not present" do
      activity = build(:activity, stem_activity_code: nil)
      expect(activity.active_course?).to eq(false)
    end
  end

  describe "#calculate_credits" do
    it "should use initial credit value" do
      activity = create(:activity, credit: 50)
      expect(activity.credit).to eq(50)
    end

    it "calculates the correct credits from duration in hours" do
      activity = create(:activity, credit: nil, duration_in_hours: 2.5)
      expect(activity.credit).to eq(25)
    end

    context "is a cs_accelerator programme activity" do
      it "creates a valid programme_activity" do
        programme = FactoryBot.create(:cs_accelerator)
        activity = FactoryBot.create(:activity)
        programme_activity = FactoryBot.create(:programme_activity, programme: programme, activity: activity)
        expect(programme_activity.activity.credit).to eq(2000)
      end
    end
  end
end
