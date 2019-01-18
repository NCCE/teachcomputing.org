module AchieverStubs
  def stub_approved_course_occurrences
    raw_future_course_occurrences_xml = File.new('spec/support/achiever_api/future_course_occurrences.xml')
      stub_request(:get, "https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow?sXmlParams=%3C?xml%20version=%221.0%22?%3E%0A%3CAchiever%3E%0A%20%20%3CCommand%3E%0A%20%20%20%20%3CCommandType%3EExternalRunWorkflow%3C/CommandType%3E%0A%20%20%20%20%3CWorkflowId%3ESOME_FUTURE_COURSES_WORKFLOW_ID%3C/WorkflowId%3E%0A%20%20%20%20%3CReturnSchemaWithXmlData%3E1%3C/ReturnSchemaWithXmlData%3E%0A%20%20%20%20%3CIdentity%3E%0A%20%20%20%20%20%20%3CDbConnectionId%3ESOME_DB_CONNECTION_ID%3C/DbConnectionId%3E%0A%20%20%20%20%3C/Identity%3E%0A%20%20%20%20%3CParameters%3E%0A%20%20%20%20%20%20%3CProgramme%3ENCCE%3C/Programme%3E%0A%20%20%20%20%3C/Parameters%3E%0A%20%20%3C/Command%3E%0A%3C/Achiever%3E%0A")
        .to_return(raw_future_course_occurrences_xml)
  end

  def stub_future_course_occurrences
    raw_future_course_templates_xml = File.new('spec/support/achiever_api/future_course_templates.xml')
    stub_request(:get, "https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow?sXmlParams=%3C?xml%20version=%221.0%22?%3E%0A%3CAchiever%3E%0A%20%20%3CCommand%3E%0A%20%20%20%20%3CCommandType%3EExternalRunWorkflow%3C/CommandType%3E%0A%20%20%20%20%3CWorkflowId%3ESOME_APPROVED_COURSE_TEMPLATES_WORKFLOW_ID%3C/WorkflowId%3E%0A%20%20%20%20%3CReturnSchemaWithXmlData%3E1%3C/ReturnSchemaWithXmlData%3E%0A%20%20%20%20%3CIdentity%3E%0A%20%20%20%20%20%20%3CDbConnectionId%3ESOME_DB_CONNECTION_ID%3C/DbConnectionId%3E%0A%20%20%20%20%3C/Identity%3E%0A%20%20%20%20%3CParameters%3E%0A%20%20%20%20%20%20%3CProgramme%3ENCCE%3C/Programme%3E%0A%20%20%20%20%3C/Parameters%3E%0A%20%20%3C/Command%3E%0A%3C/Achiever%3E%0A")
      .to_return(raw_future_course_templates_xml)
  end

  def stub_delegate_course_list
    raw_delegate_course_list_xml = File.new('spec/support/achiever_api/delegate_course_list.xml')
    stub_request(:get, "https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow")
      .with(query: hash_including({ "sXmlParams" => /SOME_COURSES_FOR_DELEGATE_WORKFLOW_ID/ }))
      .to_return(raw_delegate_course_list_xml)
  end
end
