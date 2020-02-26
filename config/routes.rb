Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'jenkins_hello#index'
  get 'jenkins_hello' => 'jenkins_hello#index'
  post 'jenkins_hello/create' => 'jenkins_hello#create'
end
