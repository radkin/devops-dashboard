class JenkinsHello < ActiveRecord::Base
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
  # this doesn't work because datetime has the time of day while this is looking for date only.
  #scope :today, lambda { where(created_at: Date.today) }
  scope :uniq_job, lambda { select(:name, :url).uniq }
end
