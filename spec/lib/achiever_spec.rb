require 'rails_helper'

RSpec.describe Achiever, type: :class do
  describe 'Achiever' do
    before do
      stub_fetch_future_courses
    end

    describe 'runWorkflow' do
      it 'runs the given workflow with the given params' do
        achiever = Achiever.new
        programme = Parameter.new('Programme', 'NCCE')
        hideFromWeb = Parameter.new('HideFromWeb', '0')

        res = achiever.runWorkflow('SOME_FUTURE_COURSES_WORKFLOW_ID', [programme, hideFromWeb])

        expect(res[0].xpath('.//Activity.Activity_Code')[0].content).to eq('CP202')
      end
    end

    describe 'fetchCourseTemplate' do
      it 'runs the course occurrence workflow with the correct param' do
        Parameter.stub(:new).with('CourseTemplateNo', 'foo') { 'bar' }
        achiever = Achiever.new
        achiever.stub(:runWorkflow)
          .with('SOME_COURSE_TEMPLATE_WORKFLOW_ID', ['bar']) { 'baz' }

        res = achiever.fetchCourseTemplate('foo')

        expect(res).to eq('baz')
      end
    end

    describe 'fetchCourseOccurrence' do
      it 'runs the course occurrence workflow with the correct param' do
        Parameter.stub(:new).with('CourseOccurrenceNo', 'foo') { 'bar' }
        achiever = Achiever.new
        achiever.stub(:runWorkflow)
          .with('SOME_COURSE_OCCURRENCE_WORKFLOW_ID', ['bar']) { 'baz' }

        res = achiever.fetchCourseOccurrence('foo')

        expect(res).to eq('baz')
      end
    end

    describe 'parseStringFromXml' do
      it 'extracts the HTML entities encoded string from an XML doc into a new doc' do
        achiever = Achiever.new
        innerXml = '<SomeTag><SomeOtherTag>Some value</SomeOtherTag></SomeTag>'
        outerXml = Nokogiri::XML::Builder.new do |xml|
          xml.string innerXml
        end

        res = achiever.parseStringFromXml(outerXml.doc).to_xml

        expect(res).to eq(Nokogiri::XML(innerXml).to_xml)
      end
    end
  end
end
