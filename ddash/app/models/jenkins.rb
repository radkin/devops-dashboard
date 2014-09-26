class Jenkins < ActiveRecord::Base
  belongs_to :masters
  belongs_to :jenkins_jobs
  belongs_to :slaves
end
