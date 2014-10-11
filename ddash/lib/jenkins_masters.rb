# All things related to Jenkins Masters
class JenkinsMasters

  def generate
    j_masters_str     = ENV['JENKINS_MASTERS']
    @jenkins_masters  = []
    j_masters_str.split(/,/).each do |master|
      @jenkins_masters.push(*master)
    end
    return @jenkins_masters
  end
end
