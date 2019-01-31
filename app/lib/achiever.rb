require('rest-client')
require('nokogiri')
require('htmlentities')
require_relative('course')
require_relative('course_template')
require_relative('parameter')

class Achiever
  def initialize
    @db_connect_id = ENV['ACHIEVER_DB_CONNECTION_ID']
    @uri = URI(ENV['ACHIEVER_API_ENDPOINT'])
    RestClient.proxy = ENV['PROXY_URL']
    @programme = Parameter.new('Programme', 'NCCE')
    @hide_from_web = Parameter.new('HideFromWeb', '0')
    @status = Parameter.new('Status', 'Approved')
  end

  def run_work_flow(workflowId, params = [])
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Achiever do
        xml.Command do
          xml.CommandType 'ExternalRunWorkflow'
          xml.WorkflowId workflowId
          xml.ReturnSchemaWithXmlData 1
          xml.Identity do
            xml.DbConnectionId @db_connect_id
          end
          xml.Parameters
        end
      end
    end

    parameters = builder.doc.xpath('//Parameters')
    params.each do |param|
      parameters[0].add_child(param.to_node)
    end

    @uri.query = URI.encode_www_form(sXmlParams: builder.to_xml)
    res = Rails.cache.fetch("#{workflowId}-#{Date.today}", expires_in: 30.minutes) do
      RestClient.get(@uri.to_s).body
    end

    doc = parse_string_from_xml(Nokogiri::XML(res))
    doc.xpath('//AchieverDataResult_1/Detail')
  end

  def approved_course_templates
    results = run_work_flow(ENV['ACHIEVER_APPROVED_COURSE_TEMPLATES_WORKFLOW_ID'], [@programme, @hide_from_web, @status])

    templates = []
    results.each do |result|
      templates << CourseTemplate.new(result)
    end
    templates
  end

  def fetch_future_courses
    results = run_work_flow(ENV['ACHIEVER_FUTURE_COURSES_WORKFLOW_ID'], [@programme, @hide_from_web, @status])

    courses = []
    results.each do |result|
      courses << Course.new(result)
    end
    courses
  end

  def fetch_course_template(id)
    course_template_no = Parameter.new('CourseTemplateNo', id)

    run_work_flow(ENV['ACHIEVER_COURSE_TEMPLATE_WORKFLOW_ID'], [course_template_no])
  end

  def fetch_course_occurrence(id)
    course_occurrence_no = Parameter.new('CourseOccurrenceNo', id)

    run_work_flow(ENV['ACHIEVER_COURSE_OCCURRENCE_WORKFLOW_ID'], [course_occurrence_no])
  end

  def fetch_courses_for_delegates(contact_no)
    contact_no = Parameter.new('ContactNo', contact_no)

    run_work_flow(ENV['ACHIEVER_COURSES_FOR_DELEGATE_WORKFLOW_ID'], [contact_no, @programme])
  end

  def parse_string_from_xml(doc)
    doc.remove_namespaces!
    Nokogiri::XML(HTMLEntities.new.decode(doc.xpath('//string/text()')))
  end
end
