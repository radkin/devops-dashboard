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

  $LOG.info("Gerrit Report")
  gen_report    = Reporter.new(gerrit_url, gerrit_user, gerrit_pass)
  gen_report.projects
end

main()
