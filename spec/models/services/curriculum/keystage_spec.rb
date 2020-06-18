require 'rails_helper'
require 'json'

RSpec.describe Curriculum, type: :request  do
  before :all do
    # .with(body: {keyStages: {id: '1', title: 'test', description: 'test'}})
    stub_request(:any, "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql").to_return(body: {data: {keyStages: []}}.to_json)
  end

  # WIP
  fit 'should return something' do
    expect(described_class::KeyStage.all).to be_a GraphQL::Client::OperationDefinition
  end

end
