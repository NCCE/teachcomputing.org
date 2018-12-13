require 'rails_helper'

RSpec.describe CoursesController do
  describe 'GET #index' do
    before do
      raw_future_courses_xml = File.new('spec/support/achiever_api/future_courses.xml')
      stub_request(:get, "https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow?sXmlParams=%3C?xml%20version=%221.0%22?%3E%0A%3CAchiever%3E%0A%20%20%3CCommand%3E%0A%20%20%20%20%3CCommandType%3EExternalRunWorkflow%3C/CommandType%3E%0A%20%20%20%20%3CWorkflowId%3ESOME_FUTURE_COURSES_WORKFLOW_ID%3C/WorkflowId%3E%0A%20%20%20%20%3CReturnSchemaWithXmlData%3E1%3C/ReturnSchemaWithXmlData%3E%0A%20%20%20%20%3CIdentity%3E%0A%20%20%20%20%20%20%3CDbConnectionId%3ESOME_DB_CONNECTION_ID%3C/DbConnectionId%3E%0A%20%20%20%20%3C/Identity%3E%0A%20%20%20%20%3CParameters%3E%0A%20%20%20%20%20%20%3CProgramme%3ENCCE%3C/Programme%3E%0A%20%20%20%20%3C/Parameters%3E%0A%20%20%3C/Command%3E%0A%3C/Achiever%3E%0A")
        .to_return(raw_future_courses_xml)
      mock_course_occurrence_fee_array = instance_double('CourseOccurrenceFeeArray',
                                                         fetchCourseOccurrenceFees: nil,
                                                         sort: [instance_double('CourseOccurrenceFee', 'fee': '440.00')]
      )
      CourseOccurrenceFeeArray.stub(:new) { mock_course_occurrence_fee_array }
      get courses_path()
    end

    it 'assigns @face_to_face_courses' do
      expect(assigns(:face_to_face_courses)).to be_a(Array)
    end

    it 'assigns @future_learn' do
      expect(assigns(:online_courses)).to be_a(FutureLearn)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end
  end
end
