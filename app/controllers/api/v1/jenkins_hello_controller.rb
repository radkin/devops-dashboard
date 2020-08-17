class Api::V1::JenkinsHelloController < ApplicationController

  # GET /jenkins_hello
  def index
    @jenkins_hellos = JenkinsHello.all
    render json: @jenkins_hellos
  end
end
