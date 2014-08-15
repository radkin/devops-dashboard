#!/usr/bin/env ruby -w

require 'logger'

# custom libs
 BASEDIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
 $: << File.join(BASEDIR, "lib")
   require "Reporter"

# Logger#debug, Logger#info, Logger#warn, Logger#error, and Logger#fatal
wrkDir      = "/var/log/devops-dashboard"
begin
  $LOG = Logger.new(
    "#{wrkDir}/devops-dashboard.log",
    10,
    1024000
  )
rescue Exception => e
  puts "unable to write to #{wrkDir}/devops-dashboard.log ... writing to stdout"
  $LOG = Logger.new($stderr)
end

#$LOG         = Logger.new($stderr)
$LOG.level    = Logger::DEBUG
#$LOG.level   = Logger::INFO
#$LOG.level   = Logger::ERROR

def main()
  gerrit_url    = ENV["GERRIT_URL"]
  gerrit_user   = ENV["GERRIT_USER"]
  gerrit_pass   = ENV["GERRIT_PASS"]

  j_masters_str     = ENV["JENKINS_MASTERS"]
  @jenkins_masters  = Array.new
  j_masters_str.split(/,/).each do |master|
    @jenkins_masters.push(*master)
  end
  jenkins_user      = ENV["JENKINS_USER"]
  jenkins_pass      = ENV["JENKINS_PASS"]

  $LOG.info("Gerrit Report")
  gen_report              = Reporter.new
  gen_report.gerrit_url   = gerrit_url
  gen_report.gerrit_user  = gerrit_user
  gen_report.gerrit_pass  = gerrit_pass
  gen_report.GerritProjects
  
  #$LOG.info("Jenkins Report")
  #gen_report                = Reporter.new
  #gen_report.jenkins_user   = jenkins_user
  #gen_report.jenkins_pass   = jenkins_pass
  #gen_report.jenkins_url    = "http://#{@jenkins_masters[0]}:8080"
  #$LOG.info("for Master #{jenkins_masters[0]}")
  #gen_report.jobs_status
end

main()
