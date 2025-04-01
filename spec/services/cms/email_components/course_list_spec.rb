require "rails_helper"

RSpec.describe Cms::EmailComponents::CourseList do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:email_template) {
    Cms::Models::EmailComponents::EmailTemplate.new(
      slug: "test",
      subject: "Test email",
      email_content: Cms::Mocks::RichBlocks.generate_data,
      programme_slug: programme.slug,
      completed_programme_activity_group_slugs: [],
      activity_state: :active
    )
  }
  let!(:activity1) { create(:activity, stem_activity_code: "CP123", programmes: [programme]) }
  let!(:activity2) { create(:activity, stem_activity_code: "CP223", programmes: [programme]) }
  let!(:sub_activity) { create(:activity, stem_activity_code: "CP323", programmes: [programme]) }
  let(:courses) {
    [
      Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP123"),
      Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP223")
    ]
  }
  let(:courses_with_sub) {
    [
      Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP123"),
      Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP223"),
      Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP323", substitute: true)
    ]
  }

  context "without substitutes" do
    before do
      @course_list = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::EmailComponents::CourseList.generate_raw_data(courses:))
    end

    context "with no achievements" do
      it "should generate correct activity list" do
        expect(@course_list.activity_list(email_template, user).count).to eq(2)
      end

      it "should render as CmsRichTextBlockComponent" do
        expect(@course_list.render(email_template, user)).to be_a(Cms::EmailCourseListComponent)
      end

      it "should render text as CourseListText" do
        expect(@course_list.render_text(email_template, user)).to be_a(Cms::EmailComponents::CourseListText)
      end
    end

    context "user has completed course" do
      let!(:completed_achievement) {
        create(:completed_achievement, user:, activity: activity1)
      }

      it "should generate correct activity list" do
        activity_list = @course_list.activity_list(email_template, user)
        expect(activity_list.count).to eq(1)
        expect(activity_list.first.activity).to eq(activity2)
      end
    end
  end

  context "with substitutes" do
    before do
      @course_list_with_sub = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::EmailComponents::CourseList.generate_raw_data(courses: courses_with_sub))
    end

    context "with no achievements" do
      it "should generate correct activity list" do
        expect(@course_list_with_sub.activity_list(email_template, user).count).to eq(2)
      end

      it "should not include substitute" do
        activities = @course_list_with_sub.activity_list(email_template, user).collect { _1.activity }
        expect(activities).not_to include(sub_activity)
      end
    end

    context "user has completed course" do
      let!(:completed_achievement) {
        create(:completed_achievement, user:, activity: activity1)
      }

      it "should generate correct activity list" do
        activity_list = @course_list_with_sub.activity_list(email_template, user)
        expect(activity_list.count).to eq(2)
        expect(activity_list.first.activity).to eq(activity2)
        expect(activity_list.second.activity).to eq(sub_activity)
      end
    end

    context "user has completed all courses" do
      before do
        create(:completed_achievement, user:, activity: activity1)
        create(:completed_achievement, user:, activity: activity2)
      end

      it "should render" do
        expect(@course_list_with_sub.render?(email_template, user)).to be true
      end

      it "should generate correct activity list" do
        activity_list = @course_list_with_sub.activity_list(email_template, user)
        expect(activity_list.count).to eq(1)
        expect(activity_list.first.activity).to eq(sub_activity)
      end
    end
  end

  context "with all courses completed" do
    let!(:completed_achievements) {
      [
        create(:completed_achievement, user:, activity: activity1),
        create(:completed_achievement, user:, activity: activity2)
      ]
    }

    before do
      @course_list = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::EmailComponents::CourseList.generate_raw_data(courses:))
    end

    it "should not render" do
      expect(@course_list.render?(email_template, user)).to be false
    end
  end

  context "with remove_on_match" do
    before do
      @course_list_with_remove = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
        Cms::Mocks::EmailComponents::CourseList.generate_raw_data(courses:, remove_on_match: true)
      )
    end

    context "no achievements" do
      it "should render as CmsRichTextBlockComponent" do
        expect(@course_list_with_remove.render(email_template, user)).to be_a(Cms::EmailCourseListComponent)
      end

      it "should render text as CourseListText" do
        expect(@course_list_with_remove.render_text(email_template, user)).to be_a(Cms::EmailComponents::CourseListText)
      end
    end

    context "when user has achievement" do
      let!(:completed_achievement) {
        create(:completed_achievement, user:, activity: activity1)
      }

      it "should return false for render?" do
        expect(@course_list_with_remove.render?(email_template, user)).to be false
      end
    end
  end
end
