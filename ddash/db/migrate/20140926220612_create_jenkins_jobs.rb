class CreateJenkinsJobs < ActiveRecord::Migration
  def change
    create_table :jenkins_jobs do |t|
      t.string :name
      t.references :builds, index: true

      t.timestamps
    end
  end
end
