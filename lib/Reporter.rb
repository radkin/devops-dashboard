# Reporter devops-dashboard library that creates reports.
class Reporter 

  attr_accessor :gerrit_url, :gerrit_user, :gerrit_pass, :jenkins_user, :jenkins_pass, :jenkins_url

# custom libs
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
  require "GerritDoorman"
  require "JenkinsDoorman"

  def initialize()
  end

  # Gerrit projects report 
  def GerritProjects
    $LOG.info("Gerrit Projects list")
    gerrit_lexicon              = GerritDoorman.new
    gerrit_lexicon.gerrit_url   = @gerrit_url
    gerrit_lexicon.gerrit_user  = @gerrit_user
    gerrit_lexicon.gerrit_pass  = @gerrit_pass
    proj_obj                    = gerrit_lexicon.door
    proj_obj.each do |key, value|
      puts key
    end
  end
  # Jenkins jobs status report 
  def jobs_status
    @red                          = 0
    @blue                         = 0
    status                        = Hash.new
    jenkins_lexicon               = JenkinsDoorman.new
    jenkins_lexicon.jenkins_url   = @jenkins_url
    jenkins_lexicon.jenkins_user  = @jenkins_user
    jenkins_lexicon.jenkins_pass  = @jenkins_pass
    proj_objects                  = jenkins_lexicon.door
    proj_objects.each do |object|
      object.each do |attributes|
        if attributes.is_a?(Array) && attributes.count > 1
          attributes.each do |line|
            if line["color"] == "red"
              @red += 1
            elsif line["color"] == "blue"
              @blue += 1
            end
          end
        end
      end
    end
    status = {"blue" => "#{@blue}", "red" => "#{@red}"}
    return status
  end

end
