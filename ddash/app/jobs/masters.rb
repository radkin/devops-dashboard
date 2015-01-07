class Masters
  require_dependency 'jenkins_masters'
  require_dependency 'jenkins_jobs_objects'

  @queue = :masters

  def self.perform
    gen_objects       = JenkinsJobsObjects.new
    masters           = JenkinsMasters.new
    @jenkins_masters  = masters.generate
    #return @jenkins_masters
    Marshal.dump(@jenkins_masters).save
  end
end

