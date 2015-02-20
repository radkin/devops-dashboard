class SwitchAvgTotalScore < ActiveRecord::Migration
  def change
    change_table :jenkins_jobs do |t|
      t.remove :avg_last_10_score
      t.integer :avg_total_score
    end
  end
end
