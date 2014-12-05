require 'resque/server'

Rails.application.routes.draw do
  resources :reports
  mount Resque::Server.new, at: "/resque"
end
