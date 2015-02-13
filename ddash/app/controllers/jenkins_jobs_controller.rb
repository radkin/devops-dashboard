# Job specific data
class JenkinsJobsController < ApplicationController
  require 'resque'
  require 'googlecharts'
  require_dependency 'jenkins_jobs_objects'
  def index
    # jobs
    @by_masters_red        = {}
    @by_masters_blue       = {}
    @by_masters_yellow     = {}
    @by_masters_grey       = {}
    @by_masters_disabled   = {}
    @by_masters_notbuilt   = {}
    @by_masters_aborted    = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @by_masters_red[master]        = JenkinsHello.by_master(master).by_color_red
      @by_masters_blue[master]       = JenkinsHello.by_master(master).by_color_blue
      @by_masters_yellow[master]     = JenkinsHello.by_master(master).by_color_yellow
      @by_masters_grey[master]       = JenkinsHello.by_master(master).by_color_grey
      @by_masters_disabled[master]   = JenkinsHello.by_master(master).by_color_disabled
      @by_masters_notbuilt[master]   = JenkinsHello.by_master(master).by_color_notbuilt
      @by_masters_aborted[master]    = JenkinsHello.by_master(master).by_color_aborted
    end
    #### charts
    # by master Job status
    @by_master_job_status_pie_chart = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @by_master_job_status_pie_chart[master] = Gchart.pie_3d(data: [@by_masters_red[master].count, @by_masters_blue[master].count, @by_masters_yellow[master].count, @by_masters_grey[master].count, @by_masters_disabled[master].count, @by_masters_notbuilt[master].count, @by_masters_aborted[master].count], title: "#{master} job status", size: '600x300', labels:     ['red', 'blue', 'yellow', 'grey', 'disabled', 'not built', 'aborted'])
    end
  end
end 
