class JenkinsJobsController < ApplicationController
  def index
    @red_jobs     = JenkinsHello.by_color_red.uniq_job
    @blue_jobs    = JenkinsHello.by_color_blue.uniq_job
  end
end
