class Jenkins < ActiveRecord::Base
  require_dependency 'reporter'
  require_dependency 'jenkins_masters'
  require_dependency 'jenkins_jobs_objects'

  kaboose           = "api/json"
  gen_report        = Reporter.new
  @gerrit_projects  = gen_report.gerrit_projects
  gen_objects       = JenkinsJobsObjects.new

  def gen_master
    # gather our list of masters and save them to the DB
    masters           = JenkinsMasters.new
    jenkins_masters   = masters.generate
    return jenkins_masters
  end

  def gen_jen_jobs
    # save jobs objects for each master
    jenkins_masters.each do |jenkins_master|
      gen_objects.jenkins_params = [
        "http://#{jenkins_master}/",
        "#{kaboose}"
      ]
      jobs_objects = gen_objects.gather
      return jobs_objects
    end
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

end
