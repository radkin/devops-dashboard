class JenkinsJobs < ActiveRecord::Base
  scope :jobs, -> { select(:name) }
  scope :buildable, -> { where(buildable: '1') }
  scope :by_master, ->(master) { where('master = ?', master) }
  def self.masters_urls
    @urls = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @urls[master] = JenkinsHello::by_master(master).url
    end
    return @urls
  end
  def self.jobs
    @jobs = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @jobs[master] = JenkinsJobs::by_master(master).jobs
    end
    return @jobs
  end

end
