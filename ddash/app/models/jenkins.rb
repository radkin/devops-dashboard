class Jenkins < ActiveRecord::Base
  require_dependency 'reporter'
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
=begin
  more_values = Jenkins.new do |it|
    @all_status.each do |status|
      it.master_url       = status['jenkins_url'].split(/http:\/\//)[1]
      it.successful_jobs  = status['blue']
      it.failed_jobs      = status['red']
      it.updated_at     = DateTime.now
    end
  end
  more_values.update_all
=end
  @jenkins_masters.each do |master|
    Jenkins.create(master: "#{master}")
  end
end
