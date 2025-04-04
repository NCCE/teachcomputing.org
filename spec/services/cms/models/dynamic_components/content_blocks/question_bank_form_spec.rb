require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::QuestionBankForm do
  before do
    stub_strapi_secondary_question_bank_collection

    @form = Cms::Providers::Strapi::Factories::ModelFactory.process_model(
      {model: Cms::Models::DynamicComponents::ContentBlocks::QuestionBankForm, key: :forms, is_array: true},
      {forms: Array.new(2) { Cms::Mocks::DynamicComponents::ContentBlocks::QuestionBankForm.generate_raw_data }}
    )
  end

  it "should render as Cms::QuestionBankForm" do
    expect(@form.first.render).to be_a(Cms::QuestionBankFormComponent)
  end

  it "should have array of question bank models" do
    expect(@form).to be_a(Array)
  end

  it "should have array count of two" do
    expect(@form.count).to eq(2)
  end
end
