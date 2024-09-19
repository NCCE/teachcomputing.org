require "rails_helper"

RSpec.describe IBelongMailer, type: :mailer do
  include ApplicationHelper
  include ExternalLinkHelper
  include NavigationHelper

  let(:user) { create(:user, first_name: "Tobias", last_name: "Doe") }
  let(:programme) { create(:i_belong) }

  before do
    programme
  end

  describe "enrolled" do
    let(:mail) { IBelongMailer.with(user: user).enrolled }
    let(:mail_subject) { "Welcome to I Belong: Encouraging girls into computer science!" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias\s*Thank you for signing up/)
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it "contains the primary course link" do
      expect(mail.body.encoded).to have_link("primary", href: course_url("CP409"))
    end

    it "contains the secondary course link" do
      expect(mail.body.encoded).to have_link("secondary", href: course_url("CP440"))
    end

    it "contains the certificate dashboard link" do
      expect(mail.body.encoded).to have_link("personal dashboard", href: i_belong_url)
    end

    it "contains the computing hub link" do
      expect(mail.body.encoded).to have_link("your local Computing Hub", href: hubs_url)
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias\s*Thank you for signing up/)
      end

      it "contains the primary course link" do
        expect(mail.text_part.body.to_s).to include("primary (#{course_url("CP409")})")
      end

      it "contains the secondary course link" do
        expect(mail.text_part.body.to_s).to include("secondary (#{course_url("CP440")})")
      end

      it "contains the certificate dashboard link" do
        expect(mail.text_part.body.to_s).to include("personal dashboard (#{i_belong_url})")
      end

      it "contains the computing hub link" do
        expect(mail.text_part.body.to_s).to include("your local Computing Hub (#{hubs_url})")
      end

      it "contains teachcomputing email address" do
        expect(mail.text_part.body.to_s).to include("info@teachcomputing.org")
      end
    end
  end

  describe "auto_enrolled" do
    let(:mail) { IBelongMailer.with(user: user).auto_enrolled }
    let(:mail_subject) { "Welcome to I Belong: Encouraging girls into computer science!" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Hi Tobias,\s*We can see you've been working/)
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it "contains the i belong link" do
      expect(mail.html_part.body.to_s).to have_link("I Belong: encouraging girls into computer science", href: about_i_belong_url)
    end

    it "contains the website link" do
      expect(mail.html_part.body.to_s).to have_link("on our website", href: about_i_belong_url)
    end

    it "contains the unenroll link" do
      expect(mail.html_part.body.to_s).to have_link("Unenrol me from the programme", href: unenroll__i_belong_auto_enrolment_url)
    end

    it "contains the certificate dashboard link" do
      expect(mail.html_part.body.to_s).to have_link("Explore activities in your dashboard", href: i_belong_url)
    end

    it "contains link to structuring evidence document" do
      expect(mail.html_part.body.to_s).to have_link("evidence",
        href: structuring_your_i_belong_evidence_url)
    end

    it "contains link to key stage 3 clear messaging" do
      expect(mail.html_part.body.to_s).to have_link("Clear messaging in digital media, Developing for the Web",
        href: curriculum_key_stage_unit_url(key_stage_slug: "key-stage-3", unit_slug: "clear-messaging-in-digital-media"))
    end

    it "contains link to key stage 3 media animations" do
      expect(mail.html_part.body.to_s).to have_link("Media - Animations",
        href: curriculum_key_stage_unit_url(key_stage_slug: "key-stage-3", unit_slug: "media-animations"))
    end

    it "contains link to programme handbook" do
      expect(mail.html_part.body.to_s).to have_link("programme handbook",
        href: i_belong_secondary_handbook_url)
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Hi Tobias,\s*We can see you've been working/)
      end

      it "contains the i belong link" do
        expect(mail.text_part.body.to_s).to include("I Belong: encouraging girls into computer science (#{about_i_belong_url})")
      end

      it "contains the website link" do
        expect(mail.text_part.body.to_s).to include("on our website (#{about_i_belong_url})")
      end

      it "contains the unenroll link" do
        expect(mail.text_part.body.to_s).to include("Unenrol me from the programme (#{unenroll__i_belong_auto_enrolment_url})")
      end

      it "contains the certificate dashboard link" do
        expect(mail.text_part.body.to_s).to include("Explore activities in your dashboard (#{i_belong_url})")
      end

      it "contains link to structuring evidence document" do
        expect(mail.text_part.body.to_s).to include("evidence (#{structuring_your_i_belong_evidence_url})")
      end

      it "contains link to key stage 3 clear messaging" do
        expect(mail.text_part.body.to_s).to include("Developing for the Web, (#{curriculum_key_stage_unit_url(key_stage_slug: "key-stage-3", unit_slug: "clear-messaging-in-digital-media")})")
      end

      it "contains link to key stage 3 media animations" do
        expect(mail.text_part.body.to_s).to include("Media - Animations (#{curriculum_key_stage_unit_url(key_stage_slug: "key-stage-3", unit_slug: "media-animations")})")
      end

      it "contains link to programme handbook" do
        expect(mail.text_part.body.to_s).to include("programme handbook (#{i_belong_secondary_handbook_url})")
      end
    end
  end

  describe "pending" do
    let(:mail) { IBelongMailer.with(user: user).pending }
    let(:mail_subject) { "Thank you for participating in the I Belong programme" }

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Thank you for participating in the I Belong programme/)
    end

    it "includes the subject in the email" do
      expect(mail.html_part.body.to_s).to include("<title>#{mail_subject}</title>")
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    it "contains link to student survey" do
      expect(mail.html_part.body.to_s).to have_link("student attitude surveys", href: i_belong_student_survey_url)
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "contains student survey url" do
        expect(mail.text_part.body.to_s).to include("(https://ncce.io/student-survey)")
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s).to include("info@teachcomputing.org")
      end
    end
  end

  describe "completed" do
    let(:mail) { IBelongMailer.with(user: user).completed }
    let(:mail_subject) do
      "Congratulations on your achievement Tobias Doe"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias.*claim your certificate for your school/m)
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    it "includes the subject in the email" do
      expect(mail.body.encoded).to include("<title>#{mail_subject}</title>")
    end

    it "includes link to press pack" do
      expect(mail.html_part.body.to_s).to have_link("Access the pack here", href: static_asset_url("I_Belong_PR_Pack-Editorial_and_Social_Media.pdf"))
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s).to include("info@teachcomputing.org")
      end

      it "includes url to press pack" do
        expect(mail.text_part.body.to_s).to include("Access the pack here (https://static.teachcomputing.org/I_Belong_PR_Pack-Editorial_and_Social_Media.pdf)")
      end
    end
  end

  describe "student_attitude_surveys" do
    let(:mail) { IBelongMailer.with(user: user).student_attitude_surveys }
    let(:mail_subject) do
      "I Belong: request your student attitude surveys today"
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Thank you for recently signing up to I Belong: encouraging girls/)
    end

    it "includes the subject in the email" do
      expect(mail.html_part.body.to_s).to include("<title>#{mail_subject}</title>")
    end

    it "contains survey link" do
      expect(mail.html_part.body.to_s).to have_link("student surveys", href: "https://ncce.io/student-survey")
    end

    it "contains mail_to link" do
      expect(mail.html_part.body.to_s).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    context "when viewing plain text" do
      it "greets the user" do
        expect(mail.text_part.body.to_s).to match(/Dear Tobias,/)
      end

      it "contains survey url" do
        expect(mail.text_part.body.to_s).to include("student surveys (https://ncce.io/student-survey)")
      end

      it "includes email address" do
        expect(mail.text_part.body.to_s).to include("For support, email info@teachcomputing.org.")
      end
    end
  end

  describe "inactive_not_completed_any_sections" do
    let(:mail) { IBelongMailer.with(user: user).inactive_not_completed_any_sections }
    let(:mail_subject) do
      "Reminder: update your progress on the I Belong programme"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Hi Tobias,\s*It's been a while since you updated/)
    end

    describe "when html" do
      it "should render in your dashboard link" do
        expect(mail.html_part.body).to have_link("in your dashboard", href: i_belong_url)
      end

      it "contains link to primary course" do
        expect(mail.html_part.body).to have_link("primary", href: course_url("CP409"))
      end

      it "contains link to secondary course" do
        expect(mail.html_part.body).to have_link("secondary", href: course_url("CP440"))
      end

      it "contains link to secondary course" do
        expect(mail.html_part.body).to have_link("secondary", href: course_url("CP440"))
      end

      it "should render a link to the primary i belong handbook" do
        expect(mail.html_part.body).to have_link("primary", href: i_belong_primary_handbook_url)
      end

      it "should render a link to the secondary i belong handbook" do
        expect(mail.html_part.body).to have_link("secondary", href: i_belong_secondary_handbook_url)
      end

      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end

      it "contains link to primary course" do
        expect(mail.text_part.body.to_s).to include("primary (#{course_url("CP409")})")
      end

      it "contains link to secondary course" do
        expect(mail.text_part.body.to_s).to include("secondary (#{course_url("CP440")})")
      end

      it "should render a link to the primary i belong handbook" do
        expect(mail.text_part.body.to_s).to include("primary (#{i_belong_primary_handbook_url})")
      end

      it "should render a link to the secondary i belong handbook" do
        expect(mail.text_part.body.to_s).to include("secondary (#{i_belong_secondary_handbook_url})")
      end

      it "should render dashboard link" do
        expect(mail.text_part.body.to_s).to include("dashboard (#{i_belong_url})")
      end
    end
  end

  describe "inactive_only_completed_one_section" do
    let(:mail) { IBelongMailer.with(user: user).inactive_only_completed_one_section }
    let(:mail_subject) do
      "Reminder: update your progress on the I Belong programme"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Hi Tobias,\s*It's been a while since you updated/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end

      it "should render a link to the primary belong handbook" do
        expect(mail.html_part.body).to have_link("primary", href: i_belong_primary_handbook_url)
      end

      it "should render a link to the secondary belong handbook" do
        expect(mail.html_part.body).to have_link("secondary", href: i_belong_secondary_handbook_url)
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end

      it "should render a link to the primary belong handbook" do
        expect(mail.text_part.body).to include("primary (#{i_belong_primary_handbook_url})")
      end

      it "should render a link to the secondary i belong handbook" do
        expect(mail.text_part.body).to include("secondary (#{i_belong_secondary_handbook_url})")
      end
    end
  end

  describe "inactive_everything_but_understanding_factors" do
    let(:mail) { IBelongMailer.with(user: user).inactive_everything_but_understanding_factors }
    let(:mail_subject) do
      "You're nearly there"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Congratulations on your progress towards/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end

      it "contains the primary course link" do
        expect(mail.html_part.body).to have_link("primary", href: course_url("CP409"))
      end

      it "contains the secondary course link" do
        expect(mail.html_part.body).to have_link("secondary", href: course_url("CP440"))
      end

      it "contains the primary course button link" do
        expect(mail.html_part.body).to have_link("Book primary course", href: course_url("CP409"))
      end

      it "contains the secondary course button link" do
        expect(mail.html_part.body).to have_link("Book secondary course", href: course_url("CP440"))
      end
    end

    describe "when text" do
      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end

      it "contains the primary course link" do
        expect(mail.text_part.body).to include("primary (#{course_url("CP409")}")
      end

      it "contains the secondary course link" do
        expect(mail.text_part.body).to include("secondary (#{course_url("CP440")}")
      end

      it "contains the book primary course link" do
        expect(mail.text_part.body).to include("Book primary course (#{course_url("CP409")}")
      end

      it "contains the book secondary course link" do
        expect(mail.text_part.body).to include("Book secondary course (#{course_url("CP440")}")
      end
    end
  end

  describe "inactive_everything_but_access_resources" do
    let(:mail) { IBelongMailer.with(user: user).inactive_everything_but_access_resources }
    let(:mail_subject) do
      "You're so close"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Congratulations on your progress towards/)
    end

    describe "when html" do
      it "should render dashboard link" do
        expect(mail.html_part.body).to have_link("dashboard", href: i_belong_url)
      end

      it "should render DIY posters link" do
        expect(mail.html_part.body).to have_link("DIY posters", href: cms_post_url(page_slug: "i-belong-poster-template"))
      end

      it "should render student surveys link" do
        expect(mail.html_part.body).to have_link("student surveys", href: cms_page_url(page_slug: "student-surveys-attitudes-to-computing"))
      end

      it "should render evidence document link" do
        expect(mail.html_part.body).to have_link("evidence", href: structuring_your_i_belong_evidence_url)
      end
    end

    describe "when text" do
      it "should render DIY posters link" do
        expect(mail.text_part.body).to include("DIY posters (#{cms_post_url(page_slug: "i-belong-poster-template")})")
      end

      it "should render student surveys link" do
        expect(mail.text_part.body).to include("student surveys (#{cms_page_url(page_slug: "student-surveys-attitudes-to-computing")})")
      end

      it "should render dashboard link" do
        expect(mail.text_part.body).to include("dashboard (#{i_belong_url})")
      end

      it "should render evidence document link" do
        expect(mail.text_part.body).to include("evidence (#{structuring_your_i_belong_evidence_url})")
      end
    end
  end

  describe "inactive_everything_but_increase_engagement" do
    let(:mail) { IBelongMailer.with(user: user).inactive_everything_but_increase_engagement }
    let(:mail_subject) do
      "You're almost there"
    end

    it "renders the headers" do
      expect(mail.subject).to eq(mail_subject)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@teachcomputing.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Dear Tobias,\s*Congratulations on your progress towards/)
    end

    describe "when html" do
      it "should render action plan link" do
        expect(mail.html_part.body).to have_link("action plan", href: i_belong_action_plan_url)
      end

      it "should render student events link" do
        expect(mail.html_part.body).to have_link("student events", href: ncce_student_events_url)
      end

      it "should render computing ambassador link" do
        expect(mail.html_part.body).to have_link("Computing Ambassador", href: stem_ambassadors_url)
      end

      it "should render the key stage 2 link" do
        expect(mail.html_part.body).to have_link("key stage 2", href: curriculum_key_stage_units_url(key_stage_slug: "key-stage-2"))
      end

      it "should render the key stage 3 link" do
        expect(mail.html_part.body).to have_link("key stage 3", href: curriculum_key_stage_units_url(key_stage_slug: "key-stage-3"))
      end

      it "should render the primary handbook link" do
        expect(mail.html_part.body).to have_link("View recommended primary activities", href: i_belong_primary_handbook_url)
      end

      it "should render the secondary handbook link" do
        expect(mail.html_part.body).to have_link("View recommended secondary activities", href: i_belong_secondary_handbook_url)
      end

      it "should render the i belong evidence link" do
        expect(mail.html_part.body).to have_link("evidence", href: structuring_your_i_belong_evidence_url)
      end
    end

    describe "when text" do
      it "should render action plan events link" do
        expect(mail.text_part.body).to include("action plan (#{i_belong_action_plan_url})")
      end

      it "should render student events link" do
        expect(mail.text_part.body).to include("student events (#{ncce_student_events_url})")
      end

      it "should render computing ambassador link" do
        expect(mail.text_part.body).to include("Computing Ambassador (#{stem_ambassadors_url})")
      end

      it "should render the key stage 2 link" do
        expect(mail.text_part.body).to include("key stage 2 (#{curriculum_key_stage_units_url(key_stage_slug: "key-stage-2")})")
      end

      it "should render the key stage 3 link" do
        expect(mail.text_part.body).to include("key stage 3 (#{curriculum_key_stage_units_url(key_stage_slug: "key-stage-3")})")
      end

      it "should render the primary handbook link" do
        expect(mail.text_part.body).to include("View recommended primary activities (#{i_belong_primary_handbook_url})")
      end

      it "should render the secondary handbook link" do
        expect(mail.text_part.body).to include("View recommended secondary activities (#{i_belong_secondary_handbook_url})")
      end

      it "should render the i belong evidence link" do
        expect(mail.text_part.body).to include("evidence (#{structuring_your_i_belong_evidence_url})")
      end
    end
  end
end
