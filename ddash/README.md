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

* startmysql
* startredis
* rails server
