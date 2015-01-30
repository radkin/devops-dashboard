class JenkinsJobs < ActiveRecord::Base
  def self.masters_urls
    @urls = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @urls[master] = JenkinsHello::by_master(master).url
    end
    return @urls
  end
end
