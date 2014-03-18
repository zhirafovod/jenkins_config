require 'nokogiri'
require 'jenkins_api_client'

module JenkinsConfig
  class Config
    # ConfigFile provide interface to change arbitrary values in XML config file
    class File

      def initialize(config_file_name, action, **kv)
        @config_file_name = config_file_name
        @xml = Nokogiri::XML(File.open(@config_file_name))
      end

      def to_s
        "#<JenkinsConfig::Config::File>"
      end

    end
  end
end
