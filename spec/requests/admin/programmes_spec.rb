require "rails_helper"

RSpec.describe "Admin::ProgrammesController" do
  let(:programme) { create(:programme) }
  let!(:programme_activity_grouping) { create(:programme_activity_grouping, programme:) }
  let!(:assessment) { create(:assessment, programme:) }
  let(:activities) do
    create_list(:activity, 4).map do |activity|
      create(
        :programme_activity,
        programme_activity_grouping: [programme_activity_grouping],
        programme: programme,
        activity: activity
      )
    end
  end
  let!(:pathway) { create(:pathway, programme:) }
  let(:pathway_activities) do
    create_list(:pathway_activity, 4).map do |activity|
      create(
        pathway: pathway,
        activity: activity
      )
    end
  end

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_programmes_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end

    it "displays all available programmes" do
      programmes = [
        Programme.cs_accelerator,
        Programme.primary_certificate,
        Programme.secondary_certificate,
        Programme.i_belong,
        Programme.a_level
      ].compact.sort_by(&:title)

      programmes.each do |programme|
        expected_link = link_to(programme.title, admin_programme_path(programme.id))
        expect(response.body).to include(expected_link)
      end
    end
  end

  describe "GET #show" do
    before do
      get admin_programme_path(programme)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end

    context "programme activity groupings" do
      it "should render programme activity grouping title" do
        expect(response.body).to include(programme.programme_activity_groupings.first.title)
      end

      it "should render programme activity groupings activity count" do
        expect(response.body).to include(programme.programme_activity_groupings.first.activities.count.to_s)
      end

      it "should render activities" do
        programme.programme_activity_groupings.first.activities.each do |activity|
          expect(response.body).to include(strip_tags(activity.title))
          expect(response.body).to include(activity.category)
        end
      end

      it "should render programme activity groupings required for completion" do
        expect(response.body).to include(programme.programme_activity_groupings.first.required_for_completion.to_s)
      end
    end

    context "pathways" do
      it "should render pathway title" do
        expect(response.body).to include(programme.pathways.first.title)
      end

      it "should render pathway activity count" do
        expect(response.body).to include(programme.pathways.first.pathway_activities.count.to_s)
      end

      it "should render activities" do
        programme.pathways.first.pathway_activities.each do |activity|
          expect(response.body).to include(strip_tags(activity.title))
          expect(response.body).to include(activity.category)
        end
      end
    end

    context "assessments" do
      it "should render the classmarker test ID" do
        expect(response.body).to include(programme.assessment.class_marker_test_id)
      end

      it "should render the classmarker assessment link" do
        expect(response.body).to include(programme.assessment.link)
      end

      it "should render the required pass percentage" do
        expect(response.body).to include(programme.assessment.required_pass_percentage.to_i.to_s)
      end
    end
  end
end
