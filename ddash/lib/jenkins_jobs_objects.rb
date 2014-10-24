# JenkinsJobObjects library that gethers jobs objects.
class JenkinsJobsObjects
  attr_accessor :jenkins_url

  # custom libs
  require_dependency 'jenkins_info'

  # gather our objects 
  def gather
    @jobs_objects                   = Array.new
    kaboose                         = "api/json"
    jenkins_lexicon                 = JenkinsInfo.new
    jenkins_lexicon.jenkins_params  = [
      "#{@jenkins_url}",
      "#{kaboose}"
    ]
    proj_objects                    = jenkins_lexicon.go
    proj_objects.each do |object|
      object.each do |attributes|
        if attributes.is_a?(Array) && attributes.count > 1
          attributes.each do |line|
            @jobs_objects.push(line)
          end
        end
      end
    end
    return @jobs_objects
  end
end
