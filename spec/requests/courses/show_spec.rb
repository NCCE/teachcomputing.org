require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }

  describe '#show' do
    describe 'while logged in' do
      before do
        raw_course_occurrence_xml = File.new('spec/support/achiever_api/course_occurrence.xml')
        stub_request(:get, "https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow?sXmlParams=%3C?xml%20version=%221.0%22?%3E%0A%3CAchiever%3E%0A%20%20%3CCommand%3E%0A%20%20%20%20%3CCommandType%3EExternalRunWorkflow%3C/CommandType%3E%0A%20%20%20%20%3CWorkflowId%3ESOME_COURSE_OCCURRENCE_WORKFLOW_ID%3C/WorkflowId%3E%0A%20%20%20%20%3CReturnSchemaWithXmlData%3E1%3C/ReturnSchemaWithXmlData%3E%0A%20%20%20%20%3CIdentity%3E%0A%20%20%20%20%20%20%3CDbConnectionId%3ESOME_DB_CONNECTION_ID%3C/DbConnectionId%3E%0A%20%20%20%20%3C/Identity%3E%0A%20%20%20%20%3CParameters%3E%0A%20%20%20%20%20%20%3CCourseOccurrenceNo%3Efoo%3C/CourseOccurrenceNo%3E%0A%20%20%20%20%3C/Parameters%3E%0A%20%20%3C/Command%3E%0A%3C/Achiever%3E%0A")
          .to_return(raw_course_occurrence_xml)
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get course_path('foo')
      end

      it 'assigns @course' do
        expect(assigns(:course)).to be_a(CourseOccurrence)
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end
    end

    describe 'while logged out' do
      before do
        get course_path('foo')
      end

      it 'should redirect to login' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
