# devops-dashboard library that opens doors to the Gerrit API.
class GerritDoorman
  attr_accessor :gerrit_params

  require 'uri'
  require 'net/http'
  require 'net/http/digest_auth'
  require 'json'

  # door, standard request for nothing fancy, requires no special information
  def door
    gerrit_user   = @gerrit_params[0]
    gerrit_pass   = @gerrit_params[1]
    gerrit_url    = @gerrit_params[2]
    $LOG.info("URL is #{gerrit_url}")
    digest_auth   = Net::HTTP::DigestAuth.new
    uri           = URI.parse "#{gerrit_url}/a/projects/"
    uri.user      = "#{gerrit_user}"
    uri.password  = "#{gerrit_pass}"
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
