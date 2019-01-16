require 'rails_helper'

RSpec.describe Achiever, type: :class do
  describe 'Achiever' do
    describe 'runWorkflow' do
      it 'runs the given workflow with the given params' do
        achiever = Achiever.new
        raw_future_course_occurrences_xml = File.new('spec/support/achiever_api/future_course_occurrences.xml')
        stub_request(:get, "https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow?sXmlParams=%3C?xml%20version=%221.0%22?%3E%0A%3CAchiever%3E%0A%20%20%3CCommand%3E%0A%20%20%20%20%3CCommandType%3EExternalRunWorkflow%3C/CommandType%3E%0A%20%20%20%20%3CWorkflowId%3ESOME_FUTURE_COURSES_WORKFLOW_ID%3C/WorkflowId%3E%0A%20%20%20%20%3CReturnSchemaWithXmlData%3E1%3C/ReturnSchemaWithXmlData%3E%0A%20%20%20%20%3CIdentity%3E%0A%20%20%20%20%20%20%3CDbConnectionId%3ESOME_DB_CONNECTION_ID%3C/DbConnectionId%3E%0A%20%20%20%20%3C/Identity%3E%0A%20%20%20%20%3CParameters%3E%0A%20%20%20%20%20%20%3CProgramme%3ENCCE%3C/Programme%3E%0A%20%20%20%20%3C/Parameters%3E%0A%20%20%3C/Command%3E%0A%3C/Achiever%3E%0A")
          .to_return(raw_future_course_occurrences_xml)
        programme = Parameter.new('Programme', 'NCCE')

        res = achiever.runWorkflow('SOME_FUTURE_COURSES_WORKFLOW_ID', [programme])

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
