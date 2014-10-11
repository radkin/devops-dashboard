class ReportsController < ApplicationController
  require_dependency 'reporter'
  require_dependency 'jenkins_masters'
  def index
    @all_status = []
    gen_report = Reporter.new
    @gerrit_projects  = gen_report.gerrit_projects
    masters           = JenkinsMasters.new
    @jenkins_masters = masters.generate
    @jenkins_masters.each do |jenkins_master|
      gen_report.jenkins_url    = "http://#{jenkins_master}/"
      status                    = gen_report.jobs_status
      @all_status.push(*status)
    end
  end
end
