module JenkinsConfig
  # JenkinsConfig library configuration
  class Config
    # API provide object configurable via API
    class API
      
      # Slave (Node)
      class Node < JenkinsApi::Client::Node

        # post_config_file from xml
        def create_config_from_file(object_name, config_file_name)
          config_xml = Nokogiri::XML(File.open(config_file_name))
          config_xml.xpath("//project/displayName").first.content = object_name
          self.create(object_name, config_xml.to_xml)
        end


      end

    end
  end
end
