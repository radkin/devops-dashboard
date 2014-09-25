class ReporterController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'rubygems'
  require 'json'
  require 'net/http'
 
  respond_to :json
  $usaGovURI = "http://api.usa.gov/jobs/search.json?query=nursing+jobs"
 
  def getJobs
    response = Net::HTTP.get_response(URI.parse($usaGovURI))
    data = response.body
    JSON.parse(data)
 
    render :text => JSON.parse(data)
  end
end 

