class JenkinsJobsHealth < ActiveRecord::Migration
  def change
    change_table :jenkins_jobs do |t|
      t.remove :url
      t.remove :number
      t.integer :score
      t.string :name
      t.boolean :buildable
    end
  end
end
