devops-dashboard
================

One stop shop for status of all your DevOps tools

* Here's how you use curl to do REST calls with supported services

*Gerrit*

`curl --digest --user $GERRIT_USER:$GERRIT_PASS  $GERRIT_URL/a/projects/`


## Supported Services

* Gerrit

## How-to

### Step 1
Define these environment variables 

Bash Example:

```bash
export GERRIT_URL="http://localhost:8080"
export GERRIT_USER="richard_castle"
export GERRIT_PASS="nikki_heat"
```

### Step 2
Run 

`bin/devops-dashboard.rb`

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

* Add Jenkins report support
* Add more reports to Gerrit reporting
