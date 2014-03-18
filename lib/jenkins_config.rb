require 'jenkins_api_client'

class JenkinsConfig
  class Config

    attr :client
    # map getters to jenkins_api_client classes 
    @api_class_getters = {
        :job  => :Job,
        :node => :Node,
        :plugin => :PluginManager,
        :user  => :User,
        :view => :View
      }
    
    def initialize
      @client = JenkinsApi::Client.new(
          :server_ip => ENV['jenkins_config_host'], 
          :username => ENV['jenkins_config_username'], 
          :password => ENV['jenkins_config_password']
        )
    end

    # map api_class to JenkinsConfig::Config getters 
    # for example, JenkinsConfig::Config.node should return Jenkins::Config::Job
    @api_class_getters.each_pair do |getter, api_class|
      # define a getter for each api_class
      define_method getter do |config|
        # get class by name for each getter and instantiate
        JenkinsConfig::Config.const_get(api_class).new(config)
      end
    end

    # rename node with name old_name to new_name
    def set_property(old_name,new_name,name)
      node_config = get_config(old_name)  # that is a string with xml as a text
      xml = Nokogiri::XML(node_config)  # parse text to xml object 
      xml.xpath("//launcher/host").first.content
    end

  end
end