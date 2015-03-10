# devops-dashboard library that provide info about Jenkins via JSON REST API.
class JenkinsInfo
  attr_accessor :jenkins_params, :uri, :http_conn, :jenkins_url

  require 'uri'
  require 'net/http'
  require 'json'

  # standard request, nothing fancy, requires no special information
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
    begin
      @uri              = URI.parse "#{@jenkins_url}#{@jenkins_params[1]}"
      go_ssl
      # if SSL doesn't work, try plain old clear text
    rescue Errno::ECONNREFUSED
      go_clear
      # retry in case we're just really busy
    rescue Errno::EHOSTUNREACH
      sleep(sleep_period)
      retry if tried == false
    end
  end

  # standard http connector
  def go_clear
    http              = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl      = false
    my                = JenkinsInfo.new
    my.uri            = @uri
    my.http_conn      = http
    app_obj           = my.connector_common
    app_obj
  end

  # https connector
  def go_ssl
    http             = Net::HTTP.new(@uri.host, 443)
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    my               = JenkinsInfo.new
    my.uri           = @uri
    my.http_conn     = http
    app_obj          = my.connector_common
    app_obj
  end

  # common elements for connections
  def connector_common
    request           = Net::HTTP::Get.new(@uri.request_uri)
    response          = @http_conn.request(request)
    if response.is_a? Net::HTTPRedirection
      puts 'handing redirect response'
      uri_string        = response['location'] if response['location']
      # try again using the new url_string
      conn                = JenkinsInfo.new
      conn.jenkins_url    = uri_string
      conn.jenkins_params = ''
      puts uri_string
      conn.go
    elsif response.is_a? Net::HTTPClientError || Net::HTTPInternalServerError
      puts 'client or server error'
      return false
    else
      app_obj           = JSON.parse(response.body)
      return app_obj
    end
  end
end
