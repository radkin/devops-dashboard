# TODO

0. JenkinsJobsObjects need to get stored somewhere so we can simply look there to generate the job details report.
0. There needs to be a method that simply iterates through all the Jenkins Masters. Put it in JenkinsMasters
0. Perhaps persisting the data via serialized object will be better than using mocks. Use this to test when there iis no connectivity
0. Used this doc to set up redis & resque
http://jimneath.org/2011/03/24/using-redis-with-ruby-on-rails.html#installing_redis
0. More inspiration
http://tutorials.jumpstartlab.com/topics/performance/background_jobs.html
0. Useful for mac users
http://naleid.com/blog/2011/03/05/running-redis-as-a-user-daemon-on-osx-with-launchd
0. order of operation:

* mysqlstart
* redisstart
* rails server

0. When the whole thing is running you can look over your resque status by going to this URL
http://localhost:3000/resque/
0. you can add the sleep job by running this command
bundle exec rake environment resque:work QUEUE=sleep

## todo

[x] Use some of the Jenkins API REST call examples in ../docs/sample_rest_calls.md
[x] Remove present useless jobs data in jenkins_jobs. Display the useful graphs on the 
page on jenkins_hellos
[ ] Find a way to access the list of jenkins job names in JenkinsJobs
[ ] create graphs which list the top five best performing jobs and lowest 5 disappointing jobs
