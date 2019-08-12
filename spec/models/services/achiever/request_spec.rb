require 'rails_helper'

RSpec.describe Achiever::Request do
  let(:successful_json_response) { File.read('spec/support/achiever/courses/occurrences_face_to_face.json') }
  let(:successful_parsed_response) { described_class.send(:parse_response, successful_json_response) }
  let(:unsuccessful_json_response) { File.read('spec/support/achiever/failure.json') }
  let(:unsuccessful_parsed_response) { described_class.send(:parse_response, unsuccessful_json_response) }

  describe 'class methods' do
    describe '#option_sets' do
      it 'returns an String' do
        stub_age_groups
        expect(described_class.option_sets('Get?cmd=Get?cmd=OptionsetAgeGroups', {})).to be_a String
      end

      context 'when unsuccessful' do
        it 'raises an Achiever::Error exception' do
          stub_a_failed_response('OptionsetAgeGroups')
          expect do
            described_class.option_sets('Get?cmd=Get?cmd=OptionsetAgeGroups', {})
          end.to raise_error(Achiever::Error)
        end
      end
    end

    describe '#resource' do
      it 'returns an Array' do
        stub_course_templates
        expect(described_class.resource('Get?cmd=Get?cmd=CourseTemplatesListingByProgramme', {})).to be_a Array
      end

      context 'when unsuccessful' do
        it 'raises an Achiever::Error exception' do
          stub_a_failed_response('CourseTemplatesListingByProgramme')
          expect do
            described_class.resource('Get?cmd=Get?cmd=CourseTemplatesListingByProgramme', {})
          end.to raise_error(Achiever::Error)
        end
      end
    end

    describe 'private methods' do
      describe '#success?' do
        it 'returns true' do
          expect(described_class.send(:success?, double(status: 200), successful_parsed_response)).to eq true
        end

        context 'when status is not 200' do
          it 'returns false' do
            expect(described_class.send(:success?, double(status: 500), unsuccessful_parsed_response)).to eq false
          end
        end

        context 'when a failure reason is present' do
          it 'returns false' do
            expect(described_class.send(:success?, double(status: 200), unsuccessful_parsed_response)).to eq false
          end
        end
      end

      describe '#query_strings' do
        it 'returns an ' do
          expect(described_class.send(:query_strings, 'query': 'string')).to eq 'query=string'
        end
      end

      describe '#parse_response' do
        it 'returns an OpenStruct object' do
          expect(described_class.send(:parse_response, successful_json_response).class).to eq OpenStruct
        end
      end
    end
  end
end
