class RenameNumBuilds < ActiveRecord::Migration
  def change
    change_table :jenkins_jobs do |t|
      t.remove :num_builds
      t.integer :numbuilds
    end
  end
end
