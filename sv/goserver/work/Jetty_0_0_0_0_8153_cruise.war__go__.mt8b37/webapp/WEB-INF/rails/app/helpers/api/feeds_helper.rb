module Api
  module FeedsHelper
    include JavaImports

    def pipeline_details_url(stage_locator, pipeline_id) #FIXME: this is a horrible name, we should name this better, especially considering this is a helper method
      stage_identifier = StageIdentifier.new(stage_locator)
      api_pipeline_instance_url :name => stage_identifier.getPipelineName(), :id => pipeline_id
    end

    def pretty_print_xml(doc)
      stream = ByteArrayOutputStream.new
      XMLWriter.new(stream, OutputFormat.createPrettyPrint()).write(doc)
      stream.toString()
    end
  end
end
