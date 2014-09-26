class CreateSlaves < ActiveRecord::Migration
  def change
    create_table :slaves do |t|
      t.string :slave
      t.string :url
      t.references :masters, index: true
      t.references :jenkins_jobs, index: true

      t.timestamps
    end
  end
end
