require 'rexml/document'
require "open-uri"

sparqlQuery = "SELECT DISTINCT * WHERE { ?s ?p ?o }"

endpoint = "http://www.iringsandbox.org/InterfaceService/12345_000/API/sparql"

uri = endpoint + "?query=" + URI.escape(sparqlQuery) + "&outputType=text/xml"

response = ""
open(uri) do |stream|
  stream.each_line do |line|
    response += line
  end
end

sparqlResult = REXML::Document.new(response)

sparqlResult.each_element('//result'){ |result|
  row = ""
  result.each_element('binding'){ |binding|
    column = binding.elements[1].text
    row += column + "\t"
  }
  puts row
}