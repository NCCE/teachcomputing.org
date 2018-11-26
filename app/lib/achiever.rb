require('net/http')
require('socksify/http')
require('nokogiri')
require('htmlentities')
require_relative('course')

class Achiever
  def initialize
    @WORKFLOW_ID = ENV['ACHIEVER_FUTURE_COURSES_WORKFLOW_ID']
    @DB_CONNECTION_ID = ENV['ACHIEVER_DB_CONNECTION_ID']
    @uri = URI('https://bookingsystem-dev.stem.org.uk:8080/WorkflowAPI/Dev/_services/workflowservice.asmx/ExecuteWorkflow')
    @http = Net::HTTP::SOCKSProxy('host.docker.internal', 8123)
  end

  def fetchFutureCourses
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Achiever {
        xml.Command {
          xml.CommandType 'ExternalRunWorkflow'
          xml.WorkflowId @WORKFLOW_ID
          xml.ReturnSchemaWithXmlData 1
          xml.Identity {
            xml.DbConnectionId @DB_CONNECTION_ID
          }
        }
      }
    end

    @uri.query = URI.encode_www_form({ :sXmlParams => builder.to_xml })

    res = @http.get_response(@uri)
    doc = parseStringFromXml(Nokogiri::XML(res.body))
    results = doc.xpath('//AchieverDataResult_1/Detail')

    courses = Array.new
    results.each do |result|
      courses << Course.new(result)
    end
    courses
  end

  def parseStringFromXml(doc)
    doc.remove_namespaces!
    Nokogiri::XML(HTMLEntities.new.decode(doc.xpath('//string/text()')))
  end
end
