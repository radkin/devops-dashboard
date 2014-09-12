#!/usr/bin/env ruby

require 'logger'

# custom libs
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reporter'

# Logger#debug, Logger#info, Logger#warn, Logger#error, and Logger#fatal
begin
  $LOG = Logger.new(
    '/var/log/devops-dashboard/devops-dashboard.log',
    10,
    1_024_000
  )
rescue Exception => e
  puts 'unable to write to #{wrk_dir}/devops-dashboard.log ... \
  writing to stdout'
  $LOG = Logger.new($stderr)
end

# $LOG         = Logger.new($stderr)
# $LOG.level   = Logger::DEBUG
# $LOG.level   = Logger::INFO
$LOG.level   = Logger::ERROR

def main
  gerrit_url    = ENV['GERRIT_URL']
  gerrit_user   = ENV['GERRIT_USER']
  gerrit_pass   = ENV['GERRIT_PASS']

  j_masters_str     = ENV['JENKINS_MASTERS']
  @jenkins_masters  = []
  j_masters_str.split(/,/).each do |master|
    @jenkins_masters.push(*master)
  end
  $LOG.info('Jenkins masters are #{@jenkins_masters}')
  jenkins_user      = ENV['JENKINS_USER']
  jenkins_pass      = ENV['JENKINS_PASS']

  $LOG.info('Gerrit Report')
  gen_report                = Reporter.new
  gerrit_params             = [ "#{gerrit_url}", "#{gerrit_user}", "#{gerrit_pass}" ]
  gen_report.gerrit_params  = gerrit_params
  gen_report.GerritProjects
  $LOG.info('Jenkins Reports')
  gen_report                = Reporter.new
  jenkins_params            = [ "#{jenkins_user}","#{jenkins_pass}" ]
  gen_report.jenkins_user   = jenkins_user
  gen_report.jenkins_pass   = jenkins_pass

  @jenkins_masters.each do |jenkins_master|
    puts "Jenkins report for #{jenkins_master}"
    gen_report.jenkins_url    = "http://#{jenkins_master}"
    status                    = gen_report.jobs_status
    puts "#{status['red']} failed jobs"
    puts "#{status['blue']} successful jobs"
  end
end

main
