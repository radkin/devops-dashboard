class RenameNumBuilds < ActiveRecord::Migration[5.2]
  def change
    change_table :jenkins_jobs do |t|
      t.remove :num_builds
      t.integer :numbuilds
    end
  end
end
