# devops-dashboard library that opens doors to the Jenkins API.
class JenkinsDoorman

  attr_accessor :jenkins_user, :jenkins_pass, :jenkins_url

  require 'uri'
  require "net/http"
  require "json"

  def initialize()
  end

  # door, the standard request that is nothing fancy and requires no special information
  def door
    $LOG.info("URL is #{@jenkins_url}/api/json")
    digest_auth   = Net::HTTP::DigestAuth.new
    uri           = URI.parse "#{@jenkins_url}/api/json"

    http              = Net::HTTP.new(uri.host, uri.port)
    request           = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth("#{@jenkins_user}", "#{@jenkins_pass}")
    response          = http.request(request)
    $LOG.debug("RAW response is ...")
    $LOG.debug(response)
    app_obj       = JSON.parse(response.body)

    return app_obj
  end

end
