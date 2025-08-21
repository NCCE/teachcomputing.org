require "rails_helper"
require "axe/rspec"

RSpec.describe("Curriculum Ratings", type: :system) do
  let(:user) { create(:user) }
  let(:lesson_json) { File.new("spec/support/curriculum/responses/lesson.json").read }

  before do
    client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
    allow(CurriculumClient::Connection).to receive(:connect).and_return(client)

    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    stub_a_valid_request(lesson_json)

    visit curriculum_key_stage_unit_lesson_path(key_stage_slug: "key-stage-3",
      unit_slug: "representations-from-clay-to-silicon", lesson_slug: "lesson-1-across-time-and-space")
  end

  context "when logged in", js: true do
    before do
      stub_a_rating_request("bbc0e7c9-2abe-49c6-9593-358794905563")
    end

    it "shows the ratings box with the expected text" do
      expect(page).to have_css(".curriculum__rating", text: "Did you find these resources useful?")
    end

    context "when a negative rating is given" do
      before do
        click_on class: "curriculum__rating--thumb-down"
      end

      describe "after clicking thumbs down" do
        it "does not show the thumbs buttons" do
          expect(page).not_to have_css(".curriculum__rating--thumb-up")
          expect(page).not_to have_css(".curriculum__rating--thumb-down")
        end

        it "shows the choices component" do
          expect(page).to have_css(".curriculum__rating-choices")
        end

        it "shows the expected text" do
          expect(page).to have_text("What did you dislike?")
        end

        it "displays all 5 checkboxes" do
          (1..5).each do |check_box|
            expect(page.body).to have_css("#rating_choice_#{check_box}_neg")
          end
        end
      end

      describe "after interacting with choices component" do
        before do
          check("rating_choice_1_neg", visible: false)
          check("rating_choice_2_neg", visible: false)
          find("[name=commit]").click
        end

        it "does not show choices component" do
          expect(page).not_to have_css(".curriculum__rating-choices")
        end

        it "shows the expected text" do
          expect(page).to have_text("Tell us more")
        end

        it "shows the text area" do
          expect(page).to have_css(".curriculum__rating-textarea")
        end
      end

      describe "after interacting with the comment component" do
        before do
          find("[name=commit]").click
          fill_in id: "comment", with: "I am not a fan"
          find("[name=commit]").click
        end

        it "does not show the textarea" do
          expect(page).not_to have_css(".curriculum__rating-textarea")
        end

        it "shows the expected text" do
          expect(page).to have_css(".curriculum__rating--text-only", text: "Thank you for your feedback!")
        end
      end
    end

    context "when a positive rating is given" do
      before do
        click_on class: "curriculum__rating--thumb-up"
      end

      describe "after clicking thumbs up" do
        it "does not show the thumbs buttons" do
          expect(page).not_to have_css(".curriculum__rating--thumb-up")
          expect(page).not_to have_css(".curriculum__rating--thumb-down")
        end

        it "shows the choices component" do
          expect(page).to have_css(".curriculum__rating-choices")
        end

        it "shows the expected text" do
          expect(page).to have_text("What did you like?")
        end

        it "displays all 5 checkboxes" do
          (1..5).each do |check_box|
            expect(page.body).to have_css("#rating_choice_#{check_box}")
          end
        end
      end

      describe "after interacting with choices component" do
        before do
          check("rating_choice_1", visible: false)
          check("rating_choice_2", visible: false)
          check("rating_choice_5", visible: false)
          find("[name=commit]").click
        end

        it "does not show choices component" do
          expect(page).not_to have_css(".curriculum__rating-choices")
        end

        it "shows the expected text" do
          expect(page).to have_text("Tell us more")
        end

        it "shows the text area" do
          expect(page).to have_css(".curriculum__rating-textarea")
        end
      end

      describe "when a reason is given for a positive rating" do
        before do
          find("[name=commit]").click
          fill_in id: "comment", with: "It was good"
          find("[name=commit]").click
        end

        it "does not show the textarea" do
          expect(page).not_to have_css(".curriculum__rating-textarea")
        end

        it "shows the expected text" do
          expect(page).to have_css(".curriculum__rating--text-only", text: "Thank you for your feedback!")
        end
      end
    end
  end
end
