require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Factories::ComponentFactory do
  context "QuestionAndAnswer" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::QuestionAndAnswer.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::QuestionAndAnswer
    end

    it "should be created in rest mode" do
      strapi_data = Cms::Providers::Strapi::Mocks::QuestionAndAnswer.generate_raw_data(mode: :rest)
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::QuestionAndAnswer
    end

    it "should be created in graphql mode" do
      strapi_data = Cms::Providers::Strapi::Mocks::QuestionAndAnswer.generate_raw_data(mode: :graphql)
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::QuestionAndAnswer
    end
  end

  context "NcceButton" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::NcceButton.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Buttons::NcceButton
    end
  end

  context "LinkedPicture" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::LinkedPicture.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::ContentBlocks::LinkedPicture
    end
  end

  context "FullWidthBanner" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FullWidthBanner.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::FullWidthBanner
    end
  end

  context "HorizontalCard" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::HorizontalCard.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::HorizontalCard
    end
  end

  context "TextWithAsides" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::TextWithAsides.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::TextWithAsides
    end
  end

  context "File" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FileLink.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::ContentBlocks::FileLink
    end
  end

  context "FullWidthText" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FullWidthText.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::FullWidthText
    end
  end

  context "CardWrapper" do
    context "PictureCard" do
      it "should create card wrapper" do
        strapi_data = Cms::Providers::Strapi::Mocks::PictureCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model).to be_a Cms::DynamicComponents::Blocks::CardWrapper
      end

      it "creates correct card model" do
        strapi_data = Cms::Providers::Strapi::Mocks::PictureCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model.cards_block).to all(be_a(Cms::DynamicComponents::ContentBlocks::PictureCard))
      end
    end

    context "ResourceCard" do
      it "should create card wrapper" do
        strapi_data = Cms::Providers::Strapi::Mocks::ResourceCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model).to be_a Cms::DynamicComponents::Blocks::CardWrapper
      end

      it "creates correct card model" do
        strapi_data = Cms::Providers::Strapi::Mocks::ResourceCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model.cards_block).to all(be_a(Cms::DynamicComponents::ContentBlocks::ResourceCard))
      end
    end

    context "NumericCard" do
      it "should create card wrapper" do
        strapi_data = Cms::Providers::Strapi::Mocks::NumericCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model).to be_a Cms::DynamicComponents::Blocks::CardWrapper
      end

      it "creates correct card model" do
        strapi_data = Cms::Providers::Strapi::Mocks::NumericCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model.cards_block).to all(be_a(Cms::DynamicComponents::ContentBlocks::NumericCard))
      end
    end
  end

  context "TestimonialRow" do
    it "should create testimonial row" do
      strapi_data = Cms::Providers::Strapi::Mocks::TestimonialRow.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::TestimonialRow
    end
  end

  context "EmbeddedVideo" do
    it "should create embedded video" do
      strapi_data = Cms::Providers::Strapi::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::ContentBlocks::EmbeddedVideo
    end
  end

  context "TwoColumnVideoSection" do
    it "should create two column video section" do
      strapi_data = Cms::Providers::Strapi::Mocks::DynamicComponents::Blocks::TwoColumnVideoSection.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::Blocks::TwoColumnVideoSection
    end
  end
end
