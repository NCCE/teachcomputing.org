require('nokogiri')
require('htmlentities')

RSpec.describe Achiever do
  describe 'Achiever' do
    describe 'fetchCourseTemplate' do
      it 'runs the course occurrence workflow with the correct param' do
        # ARRANGE
        Parameter.stub(:new).with('CourseTemplateNo', 'foo') { 'bar' }
        achiever = Achiever.new
        achiever.stub(:runWorkflow)
          .with('SOME_COURSE_TEMPLATE_WORKFLOW_ID', ['bar']) { 'baz' }

        # ACT
        res = achiever.fetchCourseTemplate('foo')

        # ASSERT
        expect(res).to eq('baz')
      end
    end

    describe 'fetchCourseOccurrence' do
      it 'runs the course occurrence workflow with the correct param' do
        # ARRANGE
        Parameter.stub(:new).with('CourseOccurrenceNo', 'foo') { 'bar' }
        achiever = Achiever.new
        achiever.stub(:runWorkflow)
          .with('SOME_COURSE_OCCURRENCE_WORKFLOW_ID', ['bar']) { 'baz' }

        # ACT
        res = achiever.fetchCourseOccurrence('foo')

        # ASSERT
        expect(res).to eq('baz')
      end
    end

    describe 'parseStringFromXml' do
      it 'extracts the HTML entities encoded string from an XML doc into a new doc' do
        # ARRANGE
        achiever = Achiever.new
        innerXml = '<SomeTag><SomeOtherTag>Some value</SomeOtherTag></SomeTag>'
        outerXml = Nokogiri::XML::Builder.new do |xml|
          xml.string innerXml
        end

        # ACT
        res = achiever.parseStringFromXml(outerXml.doc).to_xml

        # ASSERT
        expect(res).to eq(Nokogiri::XML(innerXml).to_xml)
      end
    end
  end
end
