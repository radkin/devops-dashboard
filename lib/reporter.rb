# Reporter devops-dashboard library that creates reports.
class Reporter
  attr_accessor :jenkins_url

  # custom libs
  lib = File.expand_path('../../lib', __FILE__)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
  require 'gerrit_doorman'
  require 'jenkins_doorman'

  def initialize
  end

  # Gerrit projects report
  def gerrit_projects
    $LOG.info('Gerrit Projects list')
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
      puts key
    end
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
    status = { 'blue' => "#{@blue}", 'red' => "#{@red}" }
    return status
  end
end
