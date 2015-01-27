# Job specific data
class JenkinsJobsController < ApplicationController
  require 'resque'
  require 'googlecharts'
  require_dependency 'jenkins_jobs_objects'
  def index
    # jobs
    @masters_red        = {}
    @masters_blue       = {}
    @masters_yellow     = {}
    @masters_grey       = {}
    @masters_disabled   = {}
    @masters_notbuilt   = {}
    @masters_aborted    = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @masters_red[master]        = JenkinsHello.by_master(master).by_color_red
      @masters_blue[master]       = JenkinsHello.by_master(master).by_color_blue
      @masters_yellow[master]     = JenkinsHello.by_master(master).by_color_yellow
      @masters_grey[master]       = JenkinsHello.by_master(master).by_color_grey
      @masters_disabled[master]   = JenkinsHello.by_master(master).by_color_disabled
      @masters_notbuilt[master]   = JenkinsHello.by_master(master).by_color_notbuilt
      @masters_aborted[master]    = JenkinsHello.by_master(master).by_color_aborted
    end
    #### charts
    # by master Job status
    @by_master_job_status_pie_chart = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @by_master_job_status_pie_chart[master] = Gchart.pie_3d(data: [@masters_red[master].count, @masters_blue[master].count, @masters_yellow[master].count, @masters_grey[master].count, @masters_disabled[master].count, @masters_notbuilt[master].count, @masters_aborted[master].count], title: "#{master} job status", size: '600x300', labels:     ['red', 'blue', 'yellow', 'grey', 'disabled', 'not built', 'aborted'])
    end
  end

  def create
    kaboose           = 'api/json'
    gen_objects       = JenkinsJobsObjects.new
    Ddash::Application.config.JENKINS_MASTERS.each do |jenkins_master|
      #puts JenkinsJobs::masters_urls[jenkins_master].inspect
      url_objs = JenkinsJobs::masters_urls[jenkins_master]
      if url_objs.present? 
        url_objs.each do |url_obj|
          #puts url_obj.inspect
          gen_objects.jenkins_params = [
            "#{url_obj.url}",
            "#{kaboose}"
          ]
          jobs_objects                    = gen_objects.gather
          # this could be viewed as a DOS attack without sleep
          sleep 2
          #puts jobs_objects.inspect
          # save to DB
          jobs_objects.each do |jo|
            #puts "---------------------------- Job Object from #{jenkins_master} ----------------------------"
            #puts jo.inspect
            # for now, we will only collect number, url & master
            if jo.present? && jo.has_key?('number') 
              jo[:master] = "#{jenkins_master}"
              @this_job = JenkinsJobs.new(jo)
              @this_job.save
            end
          end
        end
      end
    end
  end
end 
