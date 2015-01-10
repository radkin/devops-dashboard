class JenkinsJobsController < ApplicationController
  require 'googlecharts'
  def index
    # jobs
    @red_jobs       = JenkinsHello.by_color_red.uniq_job
    @blue_jobs      = JenkinsHello.by_color_blue.uniq_job
    @yellow_jobs    = JenkinsHello.by_color_yellow.uniq_job
    @grey_jobs      = JenkinsHello.by_color_grey.uniq_job
    @disabled_jobs  = JenkinsHello.by_color_disabled.uniq_job
    @notbuilt_jobs  = JenkinsHello.by_color_notbuilt.uniq_job
    @aborted_jobs   = JenkinsHello.by_color_aborted.uniq_job
    # jobs by master
    @masters_jobs = Hash.new
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @masters_jobs[master] = JenkinsHello.by_master(master)
    end
    # charts
    @total_job_status_pie_chart = Gchart.pie(:data => [@red_jobs.count,@blue_jobs.count,@yellow_jobs.count,@grey_jobs.count,@disabled_jobs.count,@notbuilt_jobs.count,@aborted_jobs.count], :title => 'Total job status', :size => '600x300', :labels =>     ['red','blue','yellow','grey','disabled','not built','aborted'])
    #@total_jobs_by_jenkins_master = Gchart.bar(:data => [[
  end
end
