#require 'lib/jenkins_masters'
require_dependency 'jenkins_masters'

masters                             = JenkinsMasters.new
Ddash::Application.config.LIST       = masters.generate
