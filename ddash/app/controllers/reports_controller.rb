class ReportsController < ApplicationController
  require_dependency 'reporter'
  def index
    new_reports = Reporter.new
    @reports = new_reports.gerrit_projects
    #@reports = gerrit_report.gerrit_projects
  end
end
