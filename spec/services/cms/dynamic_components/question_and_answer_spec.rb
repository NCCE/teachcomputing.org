require "rails_helper"

RSpec.describe Cms::DynamicComponents::QuestionAndAnswer do
  before do
    @button = Cms::Providers::Strapi::Factories::ComponentFactory.to_question_and_answer(Cms::Mocks::QuestionAndAnswer.generate_data)
  end

  it "should render as CmsQuestionAndAnswerComponent" do
    expect(@button.render).to be_a(CmsQuestionAndAnswerComponent)
  end
end
