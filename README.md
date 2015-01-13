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
[ ] create resque jobs that will gather up to date jenkins job information. 
[ ] allow for connection to both http and https Jenkins Servers
[ ] handling for Jenkins Servers that have network connectivity issues
