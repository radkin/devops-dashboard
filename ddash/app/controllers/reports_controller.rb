class ReportsController < ApplicationController
  require 'resque'
  require_dependency 'jenkins_masters'
  require_dependency 'reporter'
  require_dependency 'jenkins_jobs_objects'
  def index
    @all_status       = []
    kaboose           = "api/json"
    gen_report        = Reporter.new
    @gerrit_projects  = gen_report.gerrit_projects
    gen_objects       = JenkinsJobsObjects.new
    masters           = JenkinsMasters.new
    @jenkins_masters  = masters.generate
    @jenkins_masters.each do |jenkins_master|
      gen_objects.jenkins_params = [
        "http://#{jenkins_master}/",
        "#{kaboose}"
      ]
      jobs_objects                    = gen_objects.gather
      gen_report.jenkins_jobs_objects = jobs_objects
      status                          = gen_report.jobs_status
      @all_status.push(*status)
    end
  end
end

=begin
  def show_job_details
    masters           = JenkinsMasters.new
    @jenkins_masters  = masters.generate
    @jenkins_masters.each do |master|
      job_list  = JenkinsInfo.new
      job_list.master = master
      jobs = job_list.generate
      gen_report    = Reporter.new
      jobs.each do |job|
        gen_report.jenkins_job_name = job
        @details_report = gen_report.job_details
      end
    end
  end
=end
