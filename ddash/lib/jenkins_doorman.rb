# devops-dashboard library that opens doors to the Jenkins API.
class JenkinsDoorman
  attr_accessor :jenkins_params

  require 'uri'
  require 'net/http'
  require 'json'

  # door, standard request, nothing fancy, requires no special information
  def door
    jenkins_user      = ENV['JENKINS_USER']
    jenkins_pass      = ENV['JENKINS_PASS']
    jenkins_url       = @jenkins_params[0]
    uri               = URI.parse "#{jenkins_url}#{@jenkins_params[1]}"
    http              = Net::HTTP.new(uri.host, uri.port)
    request           = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth("#{jenkins_user}", "#{jenkins_pass}")
    response          = http.request(request)
    app_obj           = JSON.parse(response.body)
    return app_obj
  end
end
