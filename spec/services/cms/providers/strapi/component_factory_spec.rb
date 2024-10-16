require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Factories::ComponentFactory do
  context "QuestionAndAnswer" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::QuestionAndAnswer.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::QuestionAndAnswer
    end
  end

  context "NcceButton" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::NcceButton.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::NcceButton
    end
  end

  context "LinkedPicture" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::LinkedPicture.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::LinkedPicture
    end
  end

  context "FullWidthBanner" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FullWidthBanner.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::FullWidthBanner
    end
  end

  context "HorizontalCard" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::HorizontalCard.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::HorizontalCard
    end
  end

  context "TextWithAsides" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::TextWithAsides.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::TextWithAsides
    end
  end

  context "File" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FileLink.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::FileLink
    end
  end

  context "FullWidthText" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FullWidthText.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::FullWidthText
    end
  end

  context "CardWrapper" do
    context "PictureCard" do
      it "should create card wrapper" do
        strapi_data = Cms::Providers::Strapi::Mocks::PictureCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model).to be_a Cms::DynamicComponents::CardWrapper
      end

      it "creates correct card model" do
        strapi_data = Cms::Providers::Strapi::Mocks::PictureCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model.cards_block).to all(be_a(Cms::DynamicComponents::PictureCard))
      end
    end

    context "ResourceCard" do
      it "should create card wrapper" do
        strapi_data = Cms::Providers::Strapi::Mocks::ResourceCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model).to be_a Cms::DynamicComponents::CardWrapper
      end

      it "creates correct card model" do
        strapi_data = Cms::Providers::Strapi::Mocks::ResourceCardSection.generate_raw_data
        model = described_class.process_component(strapi_data)
        expect(model.cards_block).to all(be_a(Cms::DynamicComponents::ResourceCard))
      end
    end
  end

  context "TestimonialRow" do
    it "should create testimonial row" do
      strapi_data = Cms::Providers::Strapi::Mocks::TestimonialRow.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::TestimonialRow
    end
  end
end
