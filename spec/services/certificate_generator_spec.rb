require "rails_helper"

RSpec.describe CertificateGenerator do
  let(:output_path) { "tmp/test_generated_certificate.pdf" }
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:assessment) { create(:assessment, programme:) }
  let(:successful_assessment_attempt) { create(:completed_assessment_attempt, user:, assessment:) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

  let(:transition) do
    successful_assessment_attempt
    user_programme_enrolment.transition_to(:complete, certificate_number: 20)
    transition = user_programme_enrolment.reload.last_transition
    transition.update_attribute(:created_at, Date.new(2020, 10, 1))
    transition
  end

  let(:generator) do
    described_class.new(
      user: user,
      programme: programme,
      transition: transition,
      dependencies: {output_path: output_path}
    )
  end

  describe "#generate_pdf" do
    subject { generator.generate_pdf }

    before do
      File.delete(output_path) if File.exist?(output_path)
    end

    after do
      File.delete(output_path)
    end

    it "creates a pdf file" do
      expect(File.exist?(output_path)).to eq(false)
      generator.generate_pdf
      expect(File.exist?(output_path)).to eq(true)
    end

    it "returns filepath and filename" do
      expect(generator.generate_pdf)
        .to eq(
          {
            filename: "gcse-computer-science-subject-knowledge-certificate-202010-020.pdf",
            path: "tmp/test_generated_certificate.pdf"
          }
        )
    end
  end
end
