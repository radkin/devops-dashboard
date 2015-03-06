class RemoveUselessFields < ActiveRecord::Migration
  def change
    change_table :jenkins_jobs do |t|
      t.remove :numbuilds
    end
  end
end
