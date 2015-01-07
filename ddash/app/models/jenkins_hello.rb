class JenkinsHello < ActiveRecord::Base
  #scope :by_master, -> { where(:url => /(buildserver)/) }
  scope :by_color_red, -> { where(color: 'red') }
  scope :by_color_blue, -> { where(color: 'blue') }
  # this doesn't work because datetime has the time of day while this is looking for date only.
  #scope :today, lambda { where(created_at: Date.today) }
  scope :uniq_job, lambda { select(:name, :url).uniq }
end
