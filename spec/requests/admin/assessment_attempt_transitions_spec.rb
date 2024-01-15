require "rails_helper"

RSpec.describe "Admin::AssessmentAttemptTransitionsController" do
  let(:assessment_attempt) { create(:completed_assessment_attempt) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_assessment_attempt_transitions_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_assessment_attempt_transition_path(assessment_attempt.assessment_attempt_transitions.first)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end
end
