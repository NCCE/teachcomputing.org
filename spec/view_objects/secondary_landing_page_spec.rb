require "rails_helper"

RSpec.describe SecondaryLandingPage do
  let!(:csa) { instance_double(Programmes::CSAccelerator) }
  let!(:secondary_cert) { instance_double(Programmes::SecondaryCertificate) }
  let(:user) { create(:user) }

  let(:landing_page) { described_class.new(current_user: user) }

  before do
    allow(Programme).to receive(:cs_accelerator) { csa }
    allow(Programme).to receive(:secondary_certificate) { secondary_cert }
  end

  it "exposes csa" do
    expect(landing_page.cs_accelerator).to eq(csa)
  end

  it "exposes secondary certificate" do
    expect(landing_page.secondary_certificate).to eq(secondary_cert)
  end

  describe "#meta" do
    it "returns correctly shaped data" do
      keys = %i[title description image image_alt]

      expect(landing_page.meta.keys).to eq(keys)
    end
  end

  describe "#heading" do
    it "returns text" do
      expect(landing_page.heading).to eq("The essential toolkit for secondary computing teachers")
    end
  end

  describe "#hero_text" do
    it "returns text" do
      expect(landing_page.hero_text)
        .to eq("Training and inspiration that grows your confidence and transforms your teaching.")
    end
  end

  describe "#hero_image" do
    it "returns image path" do
      expect(landing_page.hero_image).to eq("media/images/landing-pages/sec-hero.png")
    end
  end

  describe "#hero_class" do
    it "returns lime-green-bg" do
      expect(landing_page.hero_class).to eq("lime-green-bg")
    end
  end

  describe "#event_tracking_category" do
    it "returns lime-green-bg" do
      expect(landing_page.event_tracking_category).to eq("Secondary teachers")
    end
  end

  describe "#certificates_text" do
    it "returns text" do
      expect(landing_page.certificates_text).to match(/Improve your subject knowledge/)
    end
  end

  describe "#secondary?" do
    it "returns true" do
      expect(landing_page.secondary?).to eq(true)
    end
  end

  describe "#primary?" do
    it "returns false" do
      expect(landing_page.primary?).to eq(false)
    end
  end

  describe "#csa_link_text" do
    context "when user enrolled on csa" do
      it "returns correct text" do
        allow(csa).to receive(:user_completed?)
        allow(csa).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.csa_link_text).to eq("View your progress")
      end
    end

    context "when user completes csa" do
      it "returns correct text" do
        allow(csa).to receive(:user_enrolled?)
        allow(csa).to receive(:user_completed?).and_return(true)
        expect(landing_page.csa_link_text).to eq("View certificate")
      end
    end

    context "when user not enrolled on csa" do
      it "returns correct text" do
        allow(csa).to receive(:user_completed?)
        allow(csa).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.csa_link_text).to eq("Find out more")
      end
    end
  end

  describe "#csa_tracking_event" do
    context "when user enrolled on csa" do
      it "returns correct text" do
        allow(csa).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.csa_tracking_event).to eq("CSA view progress")
      end
    end

    context "when user not enrolled on csa" do
      it "returns correct text" do
        allow(csa).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.csa_tracking_event).to eq("CSA find out more")
      end
    end
  end

  describe "#secondary_cert_link_text" do
    context "when user enrolled on secondary certificate" do
      it "returns correct text" do
        allow(secondary_cert).to receive(:user_completed?)
        allow(secondary_cert).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.secondary_cert_link_text).to eq("View your progress")
      end
    end

    context "when user completes secondary cert" do
      it "returns correct text" do
        allow(secondary_cert).to receive(:user_enrolled?)
        allow(secondary_cert).to receive(:user_completed?).and_return(true)
        expect(landing_page.secondary_cert_link_text).to eq("View certificate")
      end
    end

    context "when user not enrolled on secondary certificate" do
      it "returns correct text" do
        allow(secondary_cert).to receive(:user_completed?)
        allow(secondary_cert).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.secondary_cert_link_text).to eq("Find out more")
      end
    end
  end

  describe "#secondary_tracking_event" do
    context "when user enrolled on secondary" do
      it "returns correct text" do
        allow(secondary_cert).to receive(:user_enrolled?).and_return(true)
        expect(landing_page.secondary_tracking_event).to eq("Secondary view progress")
      end
    end

    context "when user not enrolled on secondary" do
      it "returns correct text" do
        allow(secondary_cert).to receive(:user_enrolled?).and_return(false)
        expect(landing_page.secondary_tracking_event).to eq("Secondary find out more")
      end
    end
  end

  describe "#testimonials" do
    it "returns 3 testimonials" do
      expect(landing_page.testimonials.length).to eq(3)
    end

    it "returns correctly shaped data" do
      keys = %i[text image name link_target bio tracking_event]

      expect(landing_page.testimonials.map(&:keys)).to eq(Array.new(3, keys))
    end
  end

  describe "#courses_intro" do
    it "returns text" do
      expect(landing_page.courses_intro).to match(/Begin your computing journey/)
    end
  end

  describe "#courses" do
    it "returns 3 courses" do
      expect(landing_page.courses.length).to eq(3)
    end

    it "returns correctly shaped data" do
      keys = %i[image image_title title url description icon_class type duration time_commitment event_label]

      expect(landing_page.courses.map(&:keys)).to eq([keys, keys, keys.reject { |k| k == :duration }])
    end
  end

  describe "#resources_text" do
    it "returns text" do
      expect(landing_page.resources_text).to match(/Free teaching resources/)
    end
  end

  describe "#resources" do
    it "returns 2 resources" do
      expect(landing_page.resources.length).to eq(2)
    end

    it "returns correctly shaped data" do
      keys = %i[title url description event_label updated_at]

      expect(landing_page.resources.map(&:keys)).to eq(Array.new(2, keys))
    end
  end
end
