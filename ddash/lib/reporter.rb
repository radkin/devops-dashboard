# Reporter devops-dashboard library that creates reports.
class Reporter
  attr_accessor :jenkins_jobs_objects

  # custom libs
  require_dependency 'gerrit_doorman'

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
    @blue = 0
    @red  = 0
    @jenkins_jobs_objects.each do |line|
      @red += 1 if line['color'] == 'red'
      @blue += 1 if line['color'] == 'blue'
      @jenkins_url = line['url'].split("/")[2]
    end
    status = { 'jenkins_url' => "#{@jenkins_url}", 'blue' => "#{@blue}", 'red' => "#{@red}" }
    return status
  end
=begin
  def job_details
    kaboose = "job/#{@jenkins_job_name}/api/json?tree=builds[*]"
    jenkins_lexicon.jenkins_params  = [
      "#{@jenkins_url}",
      "#{kaboose}"
    ]
    job_detail_obj = jenkins_lexicon.go
  end
=end

end
