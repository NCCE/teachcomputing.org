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

  context "FullWidthText" do
    it "should be created" do
      strapi_data = Cms::Providers::Strapi::Mocks::FullWidthText.generate_raw_data
      model = described_class.process_component(strapi_data)
      expect(model).to be_a Cms::DynamicComponents::FullWidthText
    end
  end
end
