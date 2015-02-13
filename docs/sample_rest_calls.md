# A couple of handy API REST calls

## Jenkins

https://ci.jenkins-ci.org/computer/api/json?tree=computer[displayName]

{"computer":[{"displayName":"master"},{"displayName":"celery"},{"displayName":"remote-slave-3"},{"displayName":"remote-slave-6"},{"displayName":"remote-slave-7"},{"displayName":"remote-slave-8"}]}

://ci.jenkins-ci.org/api/json?tree=jobs[name,color,buildable,healthReport[description,score,iconUrl],builds[changeSet[items[msg,user]]]]

This query gives the following things:

The job name and colour, which are self explanatory.
The healthReport, which contains useful information like how many tests are passing/exist for projects that create xunit reports. It also includes coverage statistics for python projects. Generating coverage reports with PHPUnit is unreasonably slow for the whole application, so we’ve turned it off.
The builds key contains a list of the changeSets with the messages and user who did the change set. This is used to blame people when they inevitably break the build.

