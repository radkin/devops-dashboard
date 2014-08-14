# Reporter devops-dashboard library that creates reports.
class Reporter

  #attr_accessor :app_id, :type

# custom libs
BASEDIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$: << File.join(BASEDIR, "lib")
  require "GerritDoorman"

  def initialize(gerrit_url, gerrit_user, gerrit_pass)
    @gerrit_url   = gerrit_url
    @gerrit_user  = gerrit_user
    @gerrit_pass  = gerrit_pass
  end

  # projects report generator
  def projects
    $LOG.info("Projects list")
    gerrit_lexicon          = GerritDoorman.new(@gerrit_url, @gerrit_user, @gerrit_pass)
    gerrit_lexicon.type     = "projects"
    proj_obj                = gerrit_lexicon.door
    proj_obj.each do |proj|
      puts proj
    end
  end

end
