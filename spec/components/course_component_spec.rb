require "rails_helper"

RSpec.describe CourseComponent, type: :component do
  let(:course) { build(:achiever_course_template, activity_code: "abc", title: "test course") }
  let(:always_on_course) { build(:achiever_course_template, activity_code: "abc", title: "test course", always_on: true) }
  let(:course_primary) { build(:achiever_course_template, activity_code: "abc", title: "primary test course", programmes: ["Primary"]) }
  let(:course_secondary) { build(:achiever_course_template, activity_code: "abc", title: "secondary test course", programmes: ["Secondary"]) }
  let(:filter) { instance_double(Achiever::CourseFilter) }

  before do
    allow(filter).to receive_messages(
      subjects: {"Algorithms" => 0o00000000, "Other" => 222_222_222},
      age_groups: {"Key stage 1" => 0o00000000, "Key stage 2" => 222_222_222}
    )
  end

  it "does not show the relevant messages if it is not always on" do
    render_inline(described_class.new(course: course, filter: filter))
    expect(page).not_to have_text("Free online course")
    expect(page).not_to have_text("Join anytime")
  end

  it "shows the relevant messages if it is always on" do
    render_inline(described_class.new(course: always_on_course, filter: filter))
    expect(page).to have_text("Free online course")
    expect(page).to have_text("Join anytime")
  end

  it "has a title" do
    render_inline(described_class.new(course: course, filter: filter))
    expect(page).to have_text(course.title)
  end

  it "shows link to course" do
    render_inline(described_class.new(course: course, filter: filter))
    expect(page).to have_link(course.title, href: "/courses/abc/test-course")
  end

  it "shows subjects" do
    render_inline(described_class.new(course: course, filter: filter))
    expect(page).to have_text("Algorithms")
  end

  it "shows the expected tag for a CSA course" do
    render_inline(described_class.new(course: course, filter: filter))
    expect(page).to have_text("Subject Knowledge")
  end

  it "shows the expected tag for a Primary course" do
    render_inline(described_class.new(course: course_primary, filter: filter))
    expect(page).to have_text("Primary certificate")
  end

  it "shows the expected tag for a Secondary course" do
    render_inline(described_class.new(course: course_secondary, filter: filter))
    expect(page).to have_text("Secondary certificate")
  end

  it "shows age groups" do
    render_inline(described_class.new(course: course, filter: filter))
    expect(page).to have_text("Key stage 1")
  end

  context "when there are no face-to-face or remote occurrences" do
    before do
      render_inline(described_class.new(course: course, filter: filter))
    end

    it "shows the expected message" do
      expect(page).to have_text("Dates coming soon. Contact your local Computing Hub for more information.")
    end

    it "shows the expected link" do
      expect(page).to have_link("your local Computing Hub", href: "/hubs")
    end
  end

  context "when multiple course occurrences are present" do
    let(:occurrences) { build_list(:achiever_course_occurrence, 2) }
    let(:course) { build(:achiever_course_template, occurrences: occurrences) }

    it "shows locations" do
      render_inline(described_class.new(course: course, filter: filter))
      expect(page).to have_css(".ncce-courses__locations", count: 1)
    end

    context "when distance information present" do
      let(:occurrences) { build_list(:achiever_course_occurrence, 2, distance: 3) }
      let(:course) { build(:achiever_course_template, occurrences: occurrences) }

      it "shows nearest distance" do
        render_inline(described_class.new(course: course, filter: filter))
        expect(page).to have_text("Nearest 3 miles away")
      end
    end
  end
end
