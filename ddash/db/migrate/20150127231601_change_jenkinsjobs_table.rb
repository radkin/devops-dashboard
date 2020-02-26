class ChangeJenkinsjobsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :jenkins_jobs do |t|
      t.string :number
      t.remove :name
      t.remove :color
    end
  end
end
