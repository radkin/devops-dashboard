devops-dashboard
================

One stop shop for status of all your DevOps tools

* Here's how you use curl to do REST calls with supported services

*Gerrit*

`curl --digest --user $GERRIT_USER:$GERRIT_PASS  $GERRIT_URL/a/projects/`


## Supported Services

* Gerrit
* Jenkins

## How-to

### Step 1
Define these environment variables 

Bash Example:

```bash
export GERRIT_URL="http://localhost:8080"
export GERRIT_USER="richard_castle"
export GERRIT_PASS="nikki_heat"
```

```bash
#Comma-separated list
export JENKINS_MASTERS=""
```

## #Step 2
Run 

```bash
cd ddash
rails server
```

## Useful API tips

### Jenkins

*Top Level JSON*

* assignedLabels
* mode
* nodeDescription
* nodeName
* numExecutors
* description
* jobs
* overallLoad
* primaryView
* quietingDown
* slaveAgentPort
* unlabeledLoad
* useCrumbs
* useSecurity
* views

## ToDo

[ ] (high level) add jenkins_jobs jobs drill down.
### Progress

The data is getting pulled but we can't push it into the DB because there is a wide variety of fields and only handling for 1 type of field at the moment. The fields are as follows:

* (Vast Majority) number (build), url
* name (job), url, color
* nil
* empty hash
* name (master), url, color, displayName
* description, iconClassName, iconUrl, score
* crazy complicated (see example below)

```json
{"parameterDefinitions"=>[{"defaultParameterValue"=>{"value"=>"http://updates.jenkins-ci.org/update-center.json?version=build"}, "description"=>"Update center url used for the test", "name"=>"updateCenterUrl", "type"=>"StringParamete     rDefinition"}, {"defaultParameterValue"=>{"value"=>"org.jenkins-ci.plugins:plugin:"}, "description"=>"groupId/artifactId for the parent pom which will be used.<br/>\n<u>Note</u> : If you let this field empty, every, a test on every a     lready tested core versions (in report XML file) will be made.", "name"=>"parentCoordinates", "type"=>"ChoiceParameterDefinition", "choices"=>["org.jenkins-ci.plugins:plugin:", "org.jvnet.hudson.plugins:plugin:"]}, {"defaultParameter     Value"=>{"value"=>""}, "description"=>"You can fix a version in there, if you don't want to rely on \"the latest core version retrieved in update center\"<br/>\nIf you selected the blank parentCoordinates, let this field empty please     .", "name"=>"parentVersion", "type"=>"StringParameterDefinition"}, {"defaultParameterValue"=>{"value"=>""}, "description"=>"Comma separated plugin names you want to test.<br/>\n<u>Note</u> : If you let this field empty, every plugins      residing in update center will be tested", "name"=>"includePlugins", "type"=>"StringParameterDefinition"}, {"defaultParameterValue"=>{"value"=>""}, "description"=>"Comma separated plugin names you DON'T want to test.<br/>\n<u>Note</     u> : If you let this field empty, the includePlugins policy defined below will be applied \"as is\"<br/>\nList of default excluded plugins (and reason why excluded) :<br/>\n<ul>\n<li>ci-game : Seems like on old hudsons, it doesn't wo     rk</li>\n</ul>", "name"=>"excludePlugins", "type"=>"StringParameterDefinition"}, {"defaultParameterValue"=>{"value"=>true}, "description"=>"Allow to skip plugin-compat-tester unit tests", "name"=>"maven.test.skip", "type"=>"BooleanPa     rameterDefinition"}, {"defaultParameterValue"=>{"value"=>false}, "description"=>"Allows to skip test cache. For example when you want to force testing of some plugins", "name"=>"skipTestCache", "type"=>"BooleanParameterDefinition"},      {"defaultParameterValue"=>{"value"=>"TEST_FAILURES"}, "description"=>"Allows to define a minimal cache threshold for test status.<br/>\nThat is to say, every results lower than this threshold won't be considered as part of the cache.     <br/>\nSelecting INTERNAL_ERROR here is the same as checking the skipTestCache checkbox.", "name"=>"cacheThresholdStatus", "type"=>"ChoiceParameterDefinition", "choices"=>["TEST_FAILURES", "SUCCESS", "COMPILATION_ERROR", "INTERNAL_ER     ROR "]}, {"defaultParameterValue"=>{"value"=>"1728000000"}, "description"=>"Test cache timeout allows to not perform compatibility test over some plugins if compatibility test was performed recently.<br/>\nCache timeout is given in m     illiseconds.", "name"=>"testCacheTimeout", "type"=>"StringParameterDefinition"}]}
```

[ ] create resque jobs that will gather up to date jenkins job information. 
[ ] allow for connection to both http and https Jenkins Servers
[ ] handling for Jenkins Servers that have network connectivity issues
