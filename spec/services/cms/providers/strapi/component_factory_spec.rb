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
end
