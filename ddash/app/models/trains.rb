class Trains < ActiveRecord::Base
  belongs_to :jenkins
  belongs_to :svn
  belongs_to :git
  belongs_to :gerrit
  belongs_to :gitlab
  belongs_to :jira
  belongs_to :train_route
end
