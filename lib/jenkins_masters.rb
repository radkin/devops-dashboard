# All things related to Jenkins Masters
class JenkinsMasters
  if defined?(j_masters_str)
    def generate
      j_masters_str     = ENV['JENKINS_MASTERS']
      @jenkins_masters  = []
      j_masters_str.split(/,/).each do |master|
        @jenkins_masters.push(*master)
      end
      @jenkins_masters
    end
  # if we haven't set the environment variable use localhost as a dummy value  
  else
    def generate
      @jenkins_masters = 'localhost'
    end
    @jenkins_masters
  end
end
