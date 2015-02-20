class AddScoresAvgs < ActiveRecord::Migration
  def change
    change_table :jenkins_jobs do |t|
      t.remove :score
      t.integer :avg_total_score
      t.integer :avg_last_10_score
      t.integer :num_builds
    end
  end
end
