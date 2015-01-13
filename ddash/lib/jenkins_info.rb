# devops-dashboard library that provide info about Jenkins via JSON REST API.
class JenkinsInfo
  attr_accessor :jenkins_params

  require 'uri'
  require 'net/http'
  require 'json'

  # door, standard request, nothing fancy, requires no special information
  def go
    sleep_period      = 20
    tried             = false
    @user_pass        = false
    # Check to see if we have defined user/pass and use if present
    if ENV['JENKINS_USER'] && ENV['JENKINS_PASS']
      jenkins_user      = ENV['JENKINS_USER']
      jenkins_pass      = ENV['JENKINS_PASS']
      @user_pass        = true
    end
    jenkins_url       = @jenkins_params[0]
    uri               = URI.parse "#{jenkins_url}#{@jenkins_params[1]}"
    http              = Net::HTTP.new(uri.host, 443)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    begin
      request           = Net::HTTP::Get.new(uri.request_uri)
      if @user_pass     == true
        request.basic_auth("#{jenkins_user}", "#{jenkins_pass}") 
      end
      response          = http.request(request)
      app_obj           = JSON.parse(response.body)
    return app_obj
    # if SSL doesn't work, try plain old clear text
    rescue Errno::ECONNREFUSED => e
      http.use_ssl      = false
      http              = Net::HTTP.new(uri.host, uri.port)
      request           = Net::HTTP::Get.new(uri.request_uri)
      response          = http.request(request)
      app_obj           = JSON.parse(response.body)
    # retry in case we're just really busy
    rescue Errno::EHOSTUNREACH => e
      sleep(sleep_period)
      if tried = false then retry end;
    end
  end
end
