class Report < ActiveRecord::Base
   validates :name, presence: true
  # gerrit
  gerrit_reports = Report.new do |report|
    report.name = "gerrit"
    report.type = "projects"
  end

  # jenkins job_status
  jenkins_reports = Report.new do |report|
    report.name = "jenkins"
    report.type = "job_status"
  end
end
