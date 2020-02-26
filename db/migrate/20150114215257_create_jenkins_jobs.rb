class CreateJenkinsJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jenkins_jobs do |t|
      t.string 'name'
      t.string 'url'
      t.string 'color'
      t.datetime 'created_at'
      t.string 'master'
    end
  end
end
