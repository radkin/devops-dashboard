# Reporter devops-dashboard library that creates reports.
class Reporter
  attr_accessor :jenkins_url, :jenkins_job_name

  # custom libs
  require_dependency 'gerrit_doorman'
  require_dependency 'jenkins_info'

  # Gerrit projects report
  def gerrit_projects
    @projects                     = []
    gerrit_user                   = ENV['GERRIT_USER']
    gerrit_pass                   = ENV['GERRIT_PASS']
    gerrit_url                    = ENV['GERRIT_URL']
    gerrit_lexicon                = GerritDoorman.new
    gerrit_lexicon.gerrit_params  = [
      "#{gerrit_user}",
      "#{gerrit_pass}",
      "#{gerrit_url}"
    ]
    proj_obj                      = gerrit_lexicon.door
    proj_obj.each do |key, _value|
      @projects.push(*key)
    end
    return @projects
  end
  # Jenkins jobs status report
  def jobs_status
    kaboose                        = "api/json"
    @red                            = 0
    @blue                           = 0
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
            @red += 1 if line['color'] == 'red'
            @blue += 1 if line['color'] == 'blue'
          end
        end
      end
    end
    status = { 'jenkins_url' => "#{@jenkins_url}", 'blue' => "#{@blue}", 'red' => "#{@red}" }
    puts status
    return status
  end
  def job_details
    kaboose = "job/#{@jenkins_job_name}/api/json?tree=builds[*]"
    jenkins_lexicon.jenkins_params  = [
      "#{@jenkins_url}",
      "#{kaboose}"
    ]
    job_detail_obj = jenkins_lexicon.go
  end
end
