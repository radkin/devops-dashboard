class JenkinsHelloController < ApplicationController
  require 'resque'
  require_dependency 'reporter'
  require_dependency 'jenkins_jobs_objects'
  def index
    @all_status       = []
    kaboose           = "api/json"
    gen_report        = Reporter.new
    @gerrit_projects  = gen_report.gerrit_projects
    gen_objects       = JenkinsJobsObjects.new
    Ddash::Application.config.JENKINS_MASTERS.each do |jenkins_master|
      gen_objects.jenkins_params = [
        "http://#{jenkins_master}/",
        "#{kaboose}"
      ]
      jobs_objects                    = gen_objects.gather
      # save to DB
      jobs_objects.each do |jo|
        jo[:master] = "#{jenkins_master}"
        @this_hello = JenkinsHello.new(jo)
        @this_hello.save
      end
      # generate the report
      gen_report.jenkins_jobs_objects = jobs_objects
      status                          = gen_report.jobs_status
      @all_status.push(*status)
    end
  end
  def show
  end
end
