class MakeBuildableBoolean < ActiveRecord::Migration
  def change
    change_table :jenkins_jobs do |t|
      t.remove :buildable
      t.boolean :buildable, default: false
    end
  end
end
