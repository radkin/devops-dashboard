class Jenkins < ActiveRecord::Base
  require_dependency 'reporter'
  @all_status = []
  gen_report = Reporter.new
  @gerrit_projects = gen_report.gerrit_projects
  @jenkins_masters = gen_report.gen_masters
  @jenkins_masters.each do |jenkins_master|
    gen_report.jenkins_url    = "http://#{jenkins_master}"
    status                    = gen_report.jobs_status
    @all_status.push(*status)
  end
  more_values = Jenkins.new do |it|
    @all_status.each do |status|
      it.master_url       = status['jenkins_url'].split(/http:\/\//)[1]
      it.successful_jobs  = status['blue']
      it.failed_jobs      = status['red']
      it.updated_at     = DateTime.now
    end
  end
  more_values.update_all
end
