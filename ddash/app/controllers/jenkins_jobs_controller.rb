# Job specific data
class JenkinsJobsController < ApplicationController
  require 'resque'
  require 'googlecharts'
  require_dependency 'jenkins_jobs_objects'

  def create
    # creating hellos
    kaboose           = 'api/json?tree=jobs[name,color,buildable,healthReport[description,score,iconUrl],builds[changeSet[items[msg,user]]]]'
    gen_objects       = JenkinsJobsObjects.new
    Ddash::Application.config.JENKINS_MASTERS.each do |jenkins_master|
      gen_objects.jenkins_params = [
        "http://#{jenkins_master}/",
        "#{kaboose}"
      ]
      jobs_objects                    = gen_objects.gather
      # save to DB
      jobs_objects.each do |jo|
        if jo["healthReport"].present?
          healthReport  = jo["healthReport"]
          num_builds    = Integer
          scores        = Integer
          total_last_10 = Integer
          num_builds    = 0
          scores        = 0
          healthReport.each do |part|
            if part["score"].present?
              scores += scores + part["score"]
              num_builds += 1
            end
          end
          jo[:buildable]          = jo["buildable"] 
          jo[:master]             = "#{jenkins_master}"
          jo[:name]               = jo["name"]
          jo[:avg_total_score]    = scores / num_builds
          if jo["builds"].present? 
            jo.delete("builds")
          end
          if jo["color"].present?
            jo.delete("color")
          end
          if jo["healthReport"].present?
            jo.delete("healthReport")
          end
          jo.each do |key, value|
            puts key, value
          end
          @this_jobs            = JenkinsJobs.new(jo)
          @this_jobs.save
        end
      end
    end
  end

  def index
    @masters_buildable_percent = []
    @by_masters_buildable = {}
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @by_masters_buildable[master]   = JenkinsJobs.by_master(master).buildable
    end
    # calc percent
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      percent = (@by_masters_buildable[master].count.to_f / JenkinsJobs::by_master(master).count.to_f) * 100.0
      @masters_buildable_percent.push(percent)
      puts "(#{@by_masters_buildable[master].count.to_f} / #{JenkinsJobs::by_master(master).count.to_f}) * 100.0 = #{percent} percent buildable"
    end
    # buildable percentage of jobs by master
    @buildable_jobs_jenkins_master_chart = Gchart.pie(
      data: @masters_buildable_percent,
      title: 'percent buildable jobs by master',
      size: '600x300',
      labels: JenkinsHello::masters_names)
    #Ddash::Application.config.JENKINS_MASTERS.each do |master|
    #  @by_master_buildable_pie_chart[master] = Gchart.pie_3d(data: [@by_masters_buildable[master].count, @by_masters_blue[master].count, @by_masters_yellow[master].count, @by_masters_grey[master].count, @by_masters_disabled[master].count, @by_masters_notbuilt[master].count, @by_masters_aborted[master].count], title: "#{master} job status", size: '600x300', labels:     ['red', 'blue', 'yellow', 'grey', 'disabled', 'not built', 'aborted'])
    #end
  end

end 
