# Reporter devops-dashboard library that creates reports.
class Reporter
  attr_accessor :jenkins_url

  # custom libs
  require_dependency 'gerrit_doorman'
  require_dependency 'jenkins_doorman'

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
  # gather a list of jenkins masters
  def gen_masters
    j_masters_str     = ENV['JENKINS_MASTERS']
    @jenkins_masters  = []
    j_masters_str.split(/,/).each do |master|
      @jenkins_masters.push(*master)
    end
    return @jenkins_masters
  end
  # Jenkins jobs status report
  def jobs_status
    jenkins_user                    = ENV['JENKINS_USER']
    jenkins_pass                    = ENV['JENKINS_PASS']
    @red                            = 0
    @blue                           = 0
    jenkins_lexicon                 = JenkinsDoorman.new
    jenkins_lexicon.jenkins_params  = [
      "#{jenkins_user}",
      "#{jenkins_pass}",
      "#{@jenkins_url}"
    ]
    proj_objects                    = jenkins_lexicon.door
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
    return status
  end
end
