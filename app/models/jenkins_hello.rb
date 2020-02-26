# Jenkins initial page data queries
class JenkinsHello < ActiveRecord::Base
  scope :url, -> { select(:url) }
  scope :by_color_red, -> { where(color: 'red') }
  scope :by_color_blue, -> { where(color: 'blue') }
  scope :by_color_yellow, -> { where(color: 'yellow') }
  scope :by_color_grey, -> { where(color: 'grey') }
  scope :by_color_disabled, -> { where(color: 'disabled') }
  scope :by_color_notbuilt, -> { where(color: 'notbuilt') }
  scope :by_color_aborted, -> { where(color: 'aborted') }
  scope :by_color_blueanime, -> { where(color: 'blue_anime') }
  scope :by_color_yellowanime, -> { where(color: 'yellow_anime') }
  scope :by_color_null, -> { where(color: 'NULL') }
  # .. doesnt work .. scope :today, -> { where(created_at: Date.today) }
  scope :uniq_job, -> { select(:name, :url).uniq }
  scope :by_master, ->(master) { where('master = ?', master) }
  def self.red_jobs
    by_color_red.uniq_job
  end
  def self.blue_jobs
    by_color_blue.uniq_job
  end
  def self.yellow_jobs
    by_color_yellow.uniq_job
  end
  def self.grey_jobs
    by_color_grey.uniq_job
  end
  def self.disabled_jobs
    by_color_disabled.uniq_job
  end
  def self.notbuilt_jobs
    by_color_notbuilt.uniq_job
  end
  def self.aborted_jobs
    by_color_aborted.uniq_job
  end
  def self.masters_names
    @masters_names = []
    Ddash::Application.config.JENKINS_MASTERS.each do |master|
      @masters_names.push(master)
    end
  end
end
