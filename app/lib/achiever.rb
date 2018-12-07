require('rest-client')
require('nokogiri')
require('htmlentities')
require_relative('course')
require_relative('parameter')

class Achiever
  def initialize
    @DB_CONNECTION_ID = ENV['ACHIEVER_DB_CONNECTION_ID']
    @uri = URI(ENV['ACHIEVER_API_ENDPOINT'])
    RestClient.proxy = ENV['QUOTAGUARDSTATIC_URL']
  end

  def runWorkflow(workflowId, params = [])

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Achiever {
        xml.Command {
          xml.CommandType 'ExternalRunWorkflow'
          xml.WorkflowId workflowId
          xml.ReturnSchemaWithXmlData 1
          xml.Identity {
            xml.DbConnectionId @DB_CONNECTION_ID
          }
          xml.Parameters
        }
      }
    end

    parameters = builder.doc.xpath('//Parameters')
    params.each do |param|
      parameters[0].add_child(param.to_node)
    end

    @uri.query = URI.encode_www_form({ :sXmlParams => builder.to_xml })

    res = RestClient.get(@uri.to_s)
    doc = parseStringFromXml(Nokogiri::XML(res.body))
    doc.xpath('//AchieverDataResult_1/Detail')
  end

  def fetchFutureCourses
    programme = Parameter.new('Programme', 'NCCE')

    results = self.runWorkflow(ENV['ACHIEVER_FUTURE_COURSES_WORKFLOW_ID'], [programme])

    courses = Array.new
    results.each do |result|
      courses << Course.new(result)
    end
    courses
  end

  def fetchCourseTemplate(id)
    courseTemplateNo = Parameter.new('CourseTemplateNo', id)

    self.runWorkflow(ENV['ACHIEVER_COURSE_TEMPLATE_WORKFLOW_ID'], [courseTemplateNo])
  end

  def fetchCourseOccurrence(id)
    courseOccurrenceNo = Parameter.new('CourseOccurrenceNo', id)

    self.runWorkflow(ENV['ACHIEVER_COURSE_OCCURRENCE_WORKFLOW_ID'], [courseOccurrenceNo])
  end

  def parseStringFromXml(doc)
    doc.remove_namespaces!
    Nokogiri::XML(HTMLEntities.new.decode(doc.xpath('//string/text()')))
  end
end
