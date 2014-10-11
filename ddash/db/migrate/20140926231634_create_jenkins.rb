class CreateJenkins < ActiveRecord::Migration
  def change
    create_table :jenkins do |t|
      t.string :master_url
      t.integer :successful_jobs
      t.integer :failed_jobs

      t.timestamps
    end
  end
end
