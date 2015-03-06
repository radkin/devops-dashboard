# How to duplicate
press the "create" button in jenkins hellos

# What happens?

```bash
Completed 500 Internal Server Error in 3174916ms

Errno::ETIMEDOUT (Operation timed out - connect(2) for "ci.jenkins-ci.org" port 443):
  lib/jenkins_info.rb:59:in `connector_common'
  lib/jenkins_info.rb:52:in `go_ssl'
  lib/jenkins_info.rb:22:in `go'
  lib/jenkins_jobs_objects.rb:14:in `gather'
  app/controllers/jenkins_hello_controller.rb:116:in `block (3 levels) in create'
  app/controllers/jenkins_hello_controller.rb:109:in `block (2 levels) in create'
  app/controllers/jenkins_hello_controller.rb:99:in `each'
  app/controllers/jenkins_hello_controller.rb:99:in `block in create'
  app/controllers/jenkins_hello_controller.rb:92:in `each'
  app/controllers/jenkins_hello_controller.rb:92:in `create'


  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/_source.erb (0.6ms)
  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (0.9ms)
  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (0.7ms)
  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/diagnostics.erb within rescues/layout (12.2ms)
```
