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
    @projects
  end
end
