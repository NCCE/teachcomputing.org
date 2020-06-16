# require 'rails_helper'

# RSpec.describe Curriculum::KeyStage, type: :request  do
# 	let(:key_stage) { create(:key_stage) }
# 	before do
#     stub_request(:post, 'https://curriculum.teachcomputing.rpfdev.com/graphql')
#       .with(:body => {
#         keyStages {
#           id
#           title
#           description
#       }})
#       .to_return(:body => {"keyStages": []})
#   end

#   fdescribe 'list Key Stages' do
#     it 'returns key stages' do
#       RestClient.post('https://curriculum.teachcomputing.rpfdev.com/graphql', :body => {
#         keyStages {
#           id
#           title
#           description
#       }})
#       byebug
#     end
#   end

# end
