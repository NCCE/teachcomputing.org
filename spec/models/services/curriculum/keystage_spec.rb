require 'rails_helper'
require 'json'

RSpec.describe Curriculum::KeyStage, type: :request  do
  before :all do
    #
    stub_request(:any, "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql")
      .to_return(body: {data: {
        keyStages: [
          {
            id: 0,
            title: 'test',
            description: 'test desc'
          }
        ]
      }}.to_json)
  end

  # WIP
  fit 'should return something' do
    responses = described_class.all.data
    response = responses.key_stages[0]
    expect(response.id).to eq('0')
    expect(response.title).to eq('test')
    expect(response.description).to eq('test desc')
  end

end
