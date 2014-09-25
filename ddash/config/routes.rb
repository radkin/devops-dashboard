Rails.application.routes.draw do
  get '/reporter/getJobs' => 'reporter#getJobs'
  resources :reports
end
