class CreateTrainRoutes < ActiveRecord::Migration
  def change
    create_table :train_routes do |t|
      t.string :jira_tickets
      t.string :jenkins_jobs
      t.integer :gitlab_mrs
      t.timestamp :created

      t.timestamps
    end
  end
end
