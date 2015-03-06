class JenkinsJobs < ActiveRecord::Base
  scope :buildable, -> { where(buildable: '1') }
  scope :by_master, ->(master) { where('master = ?', master) }
  scope :avg_total_score, -> { select(:avg_total_score) }
  scope :jobs, -> { select(:name) }
  def self.masters_urls
    @urls = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @urls[master] = JenkinsHello::by_master(master).url
    end
    return @urls
  end

end
