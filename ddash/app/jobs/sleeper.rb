# Sample sleep class for resque example
class Sleeper
  @queue = :sleep

  def self.perform(seconds)
    sleep(seconds)
  end
end
