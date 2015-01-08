class JenkinsJobsController < ApplicationController
  require 'googlecharts'
  def index
    @red_jobs     = JenkinsHello.by_color_red.uniq_job
    @blue_jobs    = JenkinsHello.by_color_blue.uniq_job
    @pie_chart    = Gchart.pie(:data => [@red_jobs.count,@blue_jobs.count], :title => 'Red vs Blue jobs', :size => '400x200', :labels =>     ['red', 'blue'])
  end
end
