require 'rails_helper'

RSpec.describe Achiever, type: :class do
  let(:achiever) { Achiever.new }
  let(:params) { [Parameter.new('Programme', 'NCCE'), Parameter.new('Status', 'Approved')] }
  let(:workflow_id) { '123456789' }

  describe 'Achiever' do
    before do
      stub_fetch_future_courses
    end
    
    describe '#build_request' do
      it 'generates a URL' do
        request = achiever.send(:build_request, params)
        expect(URI(request).instance_values['path']).to eq '/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow'
      end
    end

    describe '#build_params' do
      it 'includes the workflow id' do
        expect(achiever.send(:build_params, workflow_id, params)).to include workflow_id
      end

      it 'includes the correct params' do
        params.each do |param|
          expect(achiever.send(:build_params, workflow_id, params)).to include param.to_node.name
        end
      end
    end

    describe '#build_xml' do
      it 'generates an instance of Nokogiri::XML::Builder' do
        expect(achiever.send(:build_xml, workflow_id)).to be_a(Nokogiri::XML::Builder)
      end
    end

    describe '#parse_string_from_xml' do
      it 'extracts the HTML entities encoded string from an XML doc into a new doc' do
        inner_xml = '<SomeTag><SomeOtherTag>Some value</SomeOtherTag></SomeTag>'
        outer_xml = Nokogiri::XML::Builder.new do |xml|
          xml.string inner_xml
        end

        res = achiever.send(:parse_string_from_xml, outer_xml.doc).to_xml

        expect(res).to eq(Nokogiri::XML(inner_xml).to_xml)
      end
    end
  end
end
