class RemoveUselessFields < ActiveRecord::Migration[5.2]
  def change
    change_table :jenkins_jobs do |t|
      t.remove :numbuilds
    end
  end
end
