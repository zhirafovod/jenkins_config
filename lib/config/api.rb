require 'nokogiri'
require 'jenkins_api_client'

module JenkinsConfig
  # JenkinsConfig library configuration
  class Config
    # API provide object configurable via API
    class API

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
        define_method getter do |client|
          # get class by name for each getter and instantiate
          JenkinsConfig::Config::API.const_get(api_class).new(client)
        end
      end

    end
  end
end