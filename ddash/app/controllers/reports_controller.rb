class ReportsController < ApplicationController
  require_dependency 'reporter'
  def index
    @all_status = []
    gen_report = Reporter.new
    @gerrit_projects = gen_report.gerrit_projects
    @jenkins_masters = gen_report.gen_masters
    @jenkins_masters.each do |jenkins_master|
      gen_report.jenkins_url    = "http://#{jenkins_master}"
      status                    = gen_report.jobs_status
      @all_status.push(*status)
    end
  end
end
