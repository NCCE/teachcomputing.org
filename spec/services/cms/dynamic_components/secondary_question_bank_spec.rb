require "rails_helper"

RSpec.describe Cms::DynamicComponents::SecondaryQuestionBank do
  before do
    stub_strapi_secondary_question_bank_collection
    @text = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::SecondaryQuestionBank.generate_raw_data
    )
  end

  it "should render as SecondaryQuestionBankComponent" do
    expect(@text.render).to be_a(Cms::SecondaryQuestionBankComponent)
  end
end
