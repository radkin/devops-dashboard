# Parse Jenkins Masters from ENV
class Masters
  require_dependency 'jenkins_masters'
  require_dependency 'jenkins_jobs_objects'

  # old resque job to dynamically update masters
  @queue = :masters

  def self.perform
    masters           = JenkinsMasters.new
    @jenkins_masters  = masters.generate
    Marshal.dump(@jenkins_masters).save
  end
end
