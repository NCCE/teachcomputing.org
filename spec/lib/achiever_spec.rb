require 'rails_helper'

RSpec.describe Achiever, type: :class do
  describe 'Achiever' do
    before do
      stub_fetch_future_courses
    end

    describe 'run_work_flow' do
      it 'runs the given workflow with the given params' do
        achiever = Achiever.new
        programme = Parameter.new('Programme', 'NCCE')
        hide_from_web = Parameter.new('HideFromWeb', '0')

        res = achiever.run_work_flow('SOME_FUTURE_COURSES_WORKFLOW_ID', [programme, hide_from_web])

        expect(res[0].xpath('.//Activity.Activity_Code')[0].content).to eq('CP202')
      end
    end

    describe 'fetch_course_template' do
      before do
        Parameter.stub(:new).with('CourseTemplateNo', 'foo') { 'bar' }
      end

      it 'runs the course occurrence workflow with the correct param' do
        allow(Parameter).to receive(:new).and_return('bar')
        achiever = Achiever.new
        achiever.stub(:run_work_flow)
                .with('SOME_COURSE_TEMPLATE_WORKFLOW_ID', ['bar']) { 'baz' }

        res = achiever.fetch_course_template('foo')

        expect(res).to eq('baz')
      end
    end

    describe 'fetch_course_template' do
      it 'runs the course occurrence workflow with the correct param' do
        allow(Parameter).to receive(:new).and_return('bar')
        achiever = Achiever.new
        achiever.stub(:run_work_flow)
                .with('SOME_COURSE_OCCURRENCE_WORKFLOW_ID', ['bar']) { 'baz' }

        res = achiever.fetch_course_occurrence('foo')

        expect(res).to eq('baz')
      end
    end

    describe 'parse_string_from_xml' do
      it 'extracts the HTML entities encoded string from an XML doc into a new doc' do
        achiever = Achiever.new
        inner_xml = '<SomeTag><SomeOtherTag>Some value</SomeOtherTag></SomeTag>'
        outer_xml = Nokogiri::XML::Builder.new do |xml|
          xml.string inner_xml
        end

        res = achiever.parse_string_from_xml(outer_xml.doc).to_xml

        expect(res).to eq(Nokogiri::XML(inner_xml).to_xml)
      end
    end
  end
end
