# devops-dashboard library that opens doors to the Gerrit API.
class GerritDoorman

  attr_accessor :app_id, :type

  require 'uri'
  require "net/http"
  require 'net/http/digest_auth'
  require "json"

  def initialize(gerrit_url, gerrit_user, gerrit_pass)
    @gerrit_url   = gerrit_url
    @gerrit_user  = gerrit_user
    @gerrit_pass  = gerrit_pass
  end

  # door, the standard request that is nothing fancy and requires no special information
  def door
    $LOG.info("URL is #{@gerrit_url}")
    digest_auth   = Net::HTTP::DigestAuth.new
    uri           = URI.parse "#{@gerrit_url}/a/projects/"
    uri.user      = "#{@gerrit_user}"
    uri.password  = "#{@gerrit_pass}"
    h             = Net::HTTP.new uri.host, uri.port
    req           = Net::HTTP::Get.new uri.request_uri
    res           = h.request req
    auth          = digest_auth.auth_header uri, res['www-authenticate'], 'GET'
    req           = Net::HTTP::Get.new uri.request_uri
    req.add_field 'Authorization', auth
    res           = h.request req
    clean_step1   = res.body
    clean_step2   = clean_step1.split(")]}'")[1]
    app_obj       = JSON.parse(clean_step2)
    return app_obj
  end

end
