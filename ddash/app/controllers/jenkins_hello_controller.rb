class JenkinsHelloController < ApplicationController
  require 'resque'
  require 'googlecharts'
  require_dependency 'jenkins_jobs_objects'
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
    @masters_jobs       = Hash.new
    @masters_counts     = Array.new
    @masters_names      = Array.new
    @masters_aborted    = Array.new
    @masters_red        = Array.new
    @masters_blue       = Array.new
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @masters_jobs[master] = JenkinsHello.by_master(master)
      @masters_names.push(master)
      @masters_counts.push(JenkinsHello.by_master(master).count)
      @masters_aborted.push(JenkinsHello.by_master(master).by_color_aborted.count)
      @masters_red.push(JenkinsHello.by_master(master).by_color_red.count)
      @masters_blue.push(JenkinsHello.by_master(master).by_color_blue.count)
    end
    #### charts
    # Total Jobs by status
    @total_job_status_pie_chart = Gchart.pie_3d(:data => [@red_jobs.count,@blue_jobs.count,@yellow_jobs.count,@grey_jobs.count,@disabled_jobs.count,@notbuilt_jobs.count,@aborted_jobs.count], :title => 'Total job status', :size => '600x300', :labels =>     ['red','blue','yellow','grey','disabled','not built','aborted'])
    # Jobs by Jenkins Master
    @jobs_by_jenkins_master_chart = Gchart.pie(:data => @masters_counts, :title => 'Jobs by Jenkins Master', :size => '600x300', :labels =>     @masters_names)
    # Failed Jobs by Jenkins Master
    @aborted_jobs_by_jenkins_master_chart = Gchart.pie(:data => @masters_aborted, :title => 'Aborted Jobs by Jenkins Master', :size => '600x300', :labels =>     @masters_names)
    # red Jobs by Jenkins Master
    @red_jobs_by_jenkins_master_chart = Gchart.pie(:data => @masters_red, :title => 'Red Jobs by Jenkins Master', :size => '600x300', :labels =>     @masters_names)
    # blue Jobs by Jenkins Master
    @blue_jobs_by_jenkins_master_chart = Gchart.pie(:data => @masters_blue, :title => 'Blue Jobs by Jenkins Master', :size => '600x300', :labels =>     @masters_names)
  end
  def create
    @all_status       = []
    kaboose           = "api/json"
    gen_objects       = JenkinsJobsObjects.new
    Ddash::Application.config.JENKINS_MASTERS.each do |jenkins_master|
      gen_objects.jenkins_params = [
        "http://#{jenkins_master}/",
        "#{kaboose}"
      ]
      jobs_objects                    = gen_objects.gather
      # save to DB
      jobs_objects.each do |jo|
        jo[:master] = "#{jenkins_master}"
        @this_hello = JenkinsHello.new(jo)
        @this_hello.save
      end
    end
  end
end # end class
