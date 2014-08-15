# Reporter devops-dashboard library that creates reports.
class Reporter 

  attr_accessor :gerrit_url, :gerrit_user, :gerrit_pass, :jenkins_user, :jenkins_pass, :jenkins_url

# custom libs
BASEDIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$: << File.join(BASEDIR, "lib")
  require "GerritDoorman"
  require "JenkinsDoorman"

  def initialize()
  end

  # Gerrit projects report 
  def GerritProjects
    $LOG.info("Projects list")
    gerrit_lexicon              = GerritDoorman.new
    gerrit_lexicon.gerrit_url   = @gerrit_url
    gerrit_lexicon.gerrit_user  = @gerrit_user
    gerrit_lexicon.gerrit_pass  = @gerrit_pass
    proj_obj                    = gerrit_lexicon.door
    proj_obj.each do |key, value|
      puts key
    end
  end
  # Jenkins Slaves list report 
  def list_slaves
    jenkins_lexicon               = JenkinsDoorman.new
    jenkins_lexicon.jenkins_url   = @jenkins_url
    jenkins_lexicon.jenkins_user  = @jenkins_user
    jenkins_lexicon.jenkins_pass  = @jenkins_pass
    proj_obj                      = jenkins_lexicon.door
    proj_obj.each do |key, value|
      puts key
    end
  end

end
