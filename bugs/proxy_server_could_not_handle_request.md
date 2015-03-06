# bug 01

## How to duplicate this issue

* sit behind a big corporate proxy
* hit the "create" button

## Result

```bash
Completed 500 Internal Server Error in 713361ms

JSON::ParserError (757: unexpected token at '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>502 Proxy Error</title>
</head><body>
<h1>Proxy Error</h1>
<p>The proxy server received an invalid
response from an upstream server.<br />
The proxy server could not handle the request <em><a href="/job/core_selenium-test/api/json">GET&nbsp;/job/core_selenium-test/api/json</a></em>.<p>
Reason: <strong>Error reading from remote server</strong></p></p>
<hr>
<address>Apache/2.2.14 (Ubuntu) Server at ci.jenkins-ci.org Port 443</address>
</body></html>
'):
  lib/jenkins_info.rb:73:in `connector_common'
  lib/jenkins_info.rb:52:in `go_ssl'
  lib/jenkins_info.rb:22:in `go'
  lib/jenkins_jobs_objects.rb:14:in `gather'
  app/controllers/jenkins_hello_controller.rb:116:in `block (3 levels) in create'
  app/controllers/jenkins_hello_controller.rb:109:in `block (2 levels) in create'
  app/controllers/jenkins_hello_controller.rb:99:in `each'
  app/controllers/jenkins_hello_controller.rb:99:in `block in create'
  app/controllers/jenkins_hello_controller.rb:92:in `each'
  app/controllers/jenkins_hello_controller.rb:92:in `create'


  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/_source.erb (0.5ms)
  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (0.8ms)
  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (0.6ms)
  Rendered /Users/m673639/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/actionpack-4.1.6/lib/action_dispatch/middleware/templates/rescues/diagnostics.erb within rescues/layout (12.0ms)
```

## workaround

Get on a non-corp proxy network
