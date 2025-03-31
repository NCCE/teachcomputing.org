require "rails_helper"

RSpec.describe CourseComponent, type: :component do
  let(:course) { build(:achiever_course_template, activity_code: "abc", title: "test course") }
  let(:always_on_course) { build(:achiever_course_template, activity_code: "abc", title: "test course", always_on: true) }
  let(:course_primary) { build(:achiever_course_template, activity_code: "abc", title: "primary test course", programmes: ["primary-certificate"]) }
  let(:course_secondary) { build(:achiever_course_template, activity_code: "abc", title: "secondary test course", programmes: ["secondary-certificate"]) }
  let(:filter) { instance_double(Achiever::CourseFilter) }

  before do
    create(:primary_certificate)
    create(:secondary_certificate)
    create(:cs_accelerator)
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

  context "new/improve course icons" do
    it "shows a new/improved icon on new courses" do
      course.last_updated_at = Date.current
      render_inline(described_class.new(course: course, filter: filter))
      expect(page).to have_css("p.ncce-courses__new-improved-badge")
    end

    it "should not show a new/improved icon on old courses" do
      course.last_updated_at = Date.current - 4.months
      render_inline(described_class.new(course: course, filter: filter))
      expect(page).not_to have_css("img.ncce-courses__badge")
    end
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
    expect(page).to have_text(Programme.cs_accelerator.certificate_name)
  end

  it "shows the expected tag for a Primary course" do
    render_inline(described_class.new(course: course_primary, filter: filter))
    expect(page).to have_text(Programme.primary_certificate.certificate_name)
  end

  it "shows the expected tag for a Secondary course" do
    render_inline(described_class.new(course: course_secondary, filter: filter))
    expect(page).to have_text(Programme.secondary_certificate.certificate_name)
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
      expect(page).to have_text("Dates coming soon.")
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
