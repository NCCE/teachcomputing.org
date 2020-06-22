require 'rails_helper'
require 'json'

# Since there isn't a full mock of the curriculum api, we're just stubbing api responses to test;
# parameter handling, returning single instances or multiple (flat obj or array of objs)
# and error raising.

# TODO: Move stubs out to 'support'

RSpec.describe Curriculum::KeyStage do
  fdescribe 'a request for all keyStages' do
    before :each do
      stub_request(:post, "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql")
        .to_return(
          body: {
            status: 200,
            data: {
              keyStages: [
                {
                  id: 0,
                  title: 'test',
                  description: 'test desc'
                },
                {
                  id: 1,
                  title: 'test',
                  description: 'test desc'
                }
              ]
            }
          }.to_json)
    end

    it 'should return the expected count' do
      response = described_class.all
      expect(response.key_stages.count).to eq(2)
    end

    it 'should return the expected fields' do
      response = described_class.all
      key_stage = response.key_stages[0]

      expect(key_stage.id).to eq('0')
      expect(key_stage.title).to eq('test')
      expect(key_stage.description).to eq('test desc')
    end
  end

  fdescribe 'a request for one keyStage' do
    before :each do
      stub_request(:post, "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql")
        .with(body: "{\"query\":\"query Curriculum__KeyStage__KeyStage($id: ID!) {\\n  keyStage(id: $id) {\\n    id\\n    title\\n    description\\n  }\\n}\",\"variables\":{\"id\":\"1\"},\"operationName\":\"Curriculum__KeyStage__KeyStage\"}")
        .to_return(
          body: {
            status: 200,
            data: {
              keyStage: {
                id: 1,
                title: 'test',
                description: 'test desc'
              }
            }
          }.to_json)
    end

    it 'should return a valid response' do
      response = described_class.one('1')
      key_stage = response.key_stage
      expect(key_stage.id).to eq('1')
      expect(key_stage.title).to eq('test')
      expect(key_stage.description).to eq('test desc')
    end
  end

  fdescribe 'an error response' do
    before :all do
      stub_request(:any, "#{ENV.fetch('CURRICULUM_APP_URL')}/graphql")
        .to_return(body: { "errors": [
          {
            "message": "Field 'keyStages' doesn't exist on type 'Query'",
            "locations": [
              {
                "line": 2,
                "column": 3
              }
            ],
            "path": [
              "query",
              "keyStages"
            ],
            "extensions": {
              "code": "undefinedField",
              "typeName": "Query",
              "fieldName": "KeyStages"
            }
          }
        ]}.to_json)
    end

    it 'should raise an error' do
      expect{described_class.all}.to raise_error(Curriculum::QueryError)
    end
  end
end
