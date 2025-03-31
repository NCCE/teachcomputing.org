require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::QuestionAndAnswer do
  before do
    stub_strapi_aside_section("test-aside")
    data = Cms::Mocks::QuestionAndAnswer.generate_raw_data(asideSlugs: Cms::Mocks::AsideSection.generate_aside_list(aside_slugs: ["test-aside"]))
    @qa_component = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(data)
  end

  it "should render as CmsQuestionAndAnswerComponent" do
    expect(@qa_component.render).to be_a(Cms::QuestionAndAnswerComponent)
  end
end
