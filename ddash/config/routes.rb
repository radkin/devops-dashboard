require 'resque/server'

Rails.application.routes.draw do
  resources :jenkins_hello
  resources :jenkins_jobs
  #root to: main_page#index
  mount Resque::Server.new, at: '/resque'
end
