# JenkinsJobObjects library that gathers jobs objects.
class JenkinsJobsObjects
  attr_accessor :jenkins_params
  # custom libs
  require_dependency 'jenkins_info'

  # gather our objects
  def gather
    @jobs_objects                   = []
    kaboose                         = 'api/json'
    jenkins_lexicon                 = JenkinsInfo.new
    jenkins_lexicon.jenkins_params  = @jenkins_params
    proj_objects                    = jenkins_lexicon.go
    proj_objects.each do |object|
      object.each do |attributes|
        next unless attributes.is_a?(Array) && attributes.count > 1
        attributes.each { |line| @jobs_objects.push(line) }
      end
    end
    return @jobs_objects
  end
end
