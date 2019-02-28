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

  def approved_course_templates
    workflow_id = ENV['ACHIEVER_APPROVED_COURSE_TEMPLATES_WORKFLOW_ID']
    workflow_params = [@programme, @hide_from_web, @status]
    params = build_params(workflow_id, workflow_params)
    request = build_request(params)

    result = Rails.cache.fetch("#{workflow_id}-#{Date.today}", expires_in: 6.hours) do
      RestClient.get(request).body
    end

    course_templates(parse_results(result))
  end

  def future_courses
    workflow_id = ENV['ACHIEVER_FUTURE_COURSES_WORKFLOW_ID']
    workflow_params = [@programme, @hide_from_web, @status]
    params = build_params(workflow_id, workflow_params)
    request = build_request(params)

    result = Rails.cache.fetch("#{workflow_id}-#{Date.today}", expires_in: 6.hours) do
      RestClient.get(request).body
    end

    courses(parse_results(result))
  end

  def course_occurrence(id)
    workflow_id = ENV['ACHIEVER_COURSES_FOR_DELEGATE_WORKFLOW_ID']
    workflow_params = [Parameter.new('CourseOccurrenceNo', id), @programme]
    params = build_params(workflow_id, workflow_params)
    request = build_request(params)

    result = Rails.cache.fetch("#{workflow_id}-#{id}-#{Date.today}", expires_in: 12.hours) do
      RestClient.get(request).body
    end

    parse_results(result)
  end

  def courses_for_delegates(contact_no)
    workflow_id = ENV['ACHIEVER_COURSES_FOR_DELEGATE_WORKFLOW_ID']
    workflow_params = [Parameter.new('ContactNo', contact_no), @programme]
    params = build_params(workflow_id, workflow_params)
    request = build_request(params)


    result = Rails.cache.fetch("#{workflow_id}-#{contact_no}-#{Date.today}", expires_in: 12.hours) do
      RestClient.get(request).body
    end
    parse_results(result)
  end

  private

  def build_request(params)
    @uri.query = URI.encode_www_form(sXmlParams: params)
    @uri.to_s
  end

  def build_params(work_flow_id, params)
    query_xml = build_xml(work_flow_id)
    parameters = query_xml.doc.xpath('//Parameters')
    params.each do |param|
      parameters[0].add_child(param.to_node)
    end
    query_xml.to_xml
  end

  def build_xml(work_flow_id)
    Nokogiri::XML::Builder.new do |xml|
      xml.Achiever do
        xml.Command do
          xml.CommandType 'ExternalRunWorkflow'
          xml.WorkflowId work_flow_id
          xml.ReturnSchemaWithXmlData 1
          xml.Identity do
            xml.DbConnectionId @db_connect_id
          end
          xml.Parameters
        end
      end
    end
  end

  def courses(courses)
    courses.map { |course| Course.new(course) }
  end

  def course_templates(templates)
    templates.map { |template| CourseTemplate.new(template) }
  end

  def parse_results(result)
    doc = parse_string_from_xml(Nokogiri::XML(result))
    doc.xpath('//AchieverDataResult_1/Detail')
  end

  def parse_string_from_xml(doc)
    doc.remove_namespaces!
    Nokogiri::XML(HTMLEntities.new.decode(doc.xpath('//string/text()')))
  end
end
