class CreateJenkins < ActiveRecord::Migration
  def change
    create_table :jenkins do |t|
      t.references :masters, index: true
      t.references :jenkins_jobs, index: true
      t.references :slaves, index: true

      t.timestamps
    end
  end
end
