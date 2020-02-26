class MakeBuildableBoolean < ActiveRecord::Migration[5.2]
  def change
    change_table :jenkins_jobs do |t|
      t.remove :buildable
      t.boolean :buildable, default: false
    end
  end
end
