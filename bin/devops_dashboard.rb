#!/usr/bin/env ruby
# coding: utf-8

require 'logger'
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reporter'

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
$LOG.level   = Logger::ERROR

def main
  # gather a list of jenkins masters
  j_masters_str     = ENV['JENKINS_MASTERS']
  @jenkins_masters  = []
  j_masters_str.split(/,/).each do |master|
    @jenkins_masters.push(*master)
  end
  $LOG.info('Jenkins masters are #{@jenkins_masters}')
  # run gerrit report
  $LOG.info('Gerrit Report')
  gen_report                = Reporter.new
  gen_report.gerrit_projects
  # run jenkins report
  $LOG.info('Jenkins Reports')
  gen_report                = Reporter.new
  @jenkins_masters.each do |jenkins_master|
    puts "Jenkins report for #{jenkins_master}"
    gen_report.jenkins_url    = "http://#{jenkins_master}"
    status                    = gen_report.jobs_status
    puts "#{status['red']} failed jobs"
    puts "#{status['blue']} successful jobs"
  end
end
main
