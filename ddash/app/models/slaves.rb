class Slaves < ActiveRecord::Base
  belongs_to :masters
  belongs_to :jenkins_jobs
end
