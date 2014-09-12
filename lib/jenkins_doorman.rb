# devops-dashboard library that opens doors to the Jenkins API.
class JenkinsDoorman
  attr_accessor :jenkins_params

  require 'uri'
  require 'net/http'
  require 'json'

  def initialize
  end

  # door, standard request, nothing fancy, requires no special information
  def door
    jenkins_user      = @jenkins_params[0]
    jenkins_pass      = @jenkins_params[1]
    jenkins_url       = @jenkins_params[2]
    $LOG.info("URL is #{jenkins_url}/api/json")
    uri               = URI.parse "#{jenkins_url}/api/json"
    http              = Net::HTTP.new(uri.host, uri.port)
    request           = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth("#{jenkins_user}", "#{jenkins_pass}")
    response          = http.request(request)
    $LOG.debug('RAW response is ...')
    $LOG.debug(response)
    app_obj           = JSON.parse(response.body)
    return app_obj
  end
end
