require 'nokogiri'
require 'jenkins_api_client'

module JenkinsConfig
  class Config
    # Jenkins XML files
    class File
      class SystemMessage

        attr :system_message

        def Initialize(config_file, system_message=nil)
          system_message = config_file.xml.xpath('//systemMessage') unless system_message
          @system_message = system_message
        end

      end

    end
  end
end
