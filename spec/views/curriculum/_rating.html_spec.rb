require "rails_helper"

RSpec.describe("curriculum/_rating", type: :view) do
  describe "a lesson rating partial" do
    before do
      render partial: "curriculum/rating",
        locals: {path: :create_curriculum_lesson_rating_path, comment_path: :update_curriculum_lesson_rating, choices_path: :update_curriculum_unit_rating_choices, id: "an_id",
                 user_id: "user_id"}
    end

    it "renders the thumbs up link with expected route" do
      expect(rendered).to have_link(nil, href: "/curriculum/rating/lessons/positive/an_id/user_id")
    end

    it "renders the thumbs down link with expected route" do
      expect(rendered).to have_link(nil, href: "/curriculum/rating/lessons/negative/an_id/user_id")
    end
  end

  describe "a unit rating partial" do
    before do
      render partial: "curriculum/rating",
        locals: {path: :create_curriculum_unit_rating_path, comment_path: :update_curriculum_unit_rating, choices_path: :update_curriculum_unit_rating_choices, id: "an_id",
                 user_id: "user_id"}
    end

    it "renders the thumbs up link with expected route" do
      expect(rendered).to have_link(nil, href: "/curriculum/rating/units/positive/an_id/user_id")
    end

    it "renders the thumbs down link with expected route" do
      expect(rendered).to have_link(nil, href: "/curriculum/rating/units/negative/an_id/user_id")
    end
  end

  describe "a user who has previously done a rating" do
    before do
      allow_any_instance_of(CurriculumHelper)
        .to receive(:user_has_rated?).and_return(true)

      render partial: "curriculum/rating",
        locals: {path: :create_curriculum_unit_rating_path, comment_path: :update_curriculum_unit_rating, id: "an_id",
                 user_id: "user_id"}
    end

    it "renders with the expected message" do
      expect(rendered).to have_text("You have already provided a rating, thank you!")
    end
  end
end
